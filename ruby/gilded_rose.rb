# frozen_string_literal: true

class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality  #
    @items.each do |item|
      if (item.name != 'Aged Brie') && (item.name != 'Backstage passes to a TAFKAL80ETC concert')
        item.quality = item.quality - 1 if item.quality.positive? && (item.name != 'Sulfuras, Hand of Ragnaros')
      elsif item.quality < 50
        item.quality = item.quality + 1
        if item.name == 'Backstage passes to a TAFKAL80ETC concert'
          item.quality = item.quality + 1 if item.sell_in < 11 && (item.quality < 50)
          item.quality = item.quality + 1 if item.sell_in < 6 && (item.quality < 50)
        end
      end
      item.sell_in = item.sell_in - 1 if item.name != 'Sulfuras, Hand of Ragnaros'
      if item.sell_in.negative?
        if item.name != 'Aged Brie'
          if item.name != 'Backstage passes to a TAFKAL80ETC concert'
            item.quality = item.quality - 1 if item.quality.positive? && (item.name != 'Sulfuras, Hand of Ragnaros')
          else
            item.quality = item.quality - item.quality
          end
        elsif item.quality < 50
          item.quality = item.quality + 1
        end
      end
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end

=begin

Hola y bienvenido al equipo de Gilded Rose. Como saben, somos una pequeña posada con una ubicación 
privilegiada en una ciudad prominente dirigida por una amigable posadera llamada Allison. 
También compramos y vendemos solo los mejores productos. Desafortunadamente, nuestros productos degradan 
constantemente su calidad a medida que se acercan a la fecha de caducidad. Contamos con un sistema q
ue actualiza nuestro inventario por nosotros. Fue desarrollado por un tipo con poso sentiro llamado Leeroy, 
que ha pasado a nuevas aventuras. Su tarea es agregar la nueva función a nuestro sistema para que 
podamos comenzar a vender una nueva categoría de artículos. Primero una introducción a nuestro sistema:

- Todos los artículos tienen un valor SellIn que indica el número de días que tenemos para vender 
el artículo.

- Todos los artículos tienen un valor de Calidad que indica el valor del artículo.

- Al final de cada día, nuestro sistema reduce ambos valores para cada artículo.
Bastante simple, ¿verdad? Bueno, aquí es donde se pone interesante:

- Una vez que ha pasado la fecha de caducidad, la calidad se degrada dos veces más rápido
- La calidad de un artículo nunca es negativa.
- "Aged Brie" en realidad aumenta en calidad a medida que envejece
- La calidad de un artículo nunca es superior a 50
- "Sulfuras", al ser un artículo legendario, nunca tiene que venderse ni disminuye su calidad
- Los "pases entre bastidores", como el queso brie añejo, aumentan en calidad a medida que se 
acerca su valor SellIn;
La calidad aumenta en 2 cuando hay 10 días o menos y en 3 cuando hay 5 días o menos pero
La calidad cae a 0 después del concierto.
Recientemente hemos contratado a un proveedor de artículos conjurados. Esto requiere una 
actualización de nuestro sistema:

- Los elementos "conjurados" se degradan en calidad dos veces más rápido que los elementos normales
No dude en realizar cambios en el método UpdateQuality y agregar cualquier código nuevo siempre 
que todo funcione correctamente. Sin embargo, no modifiques la clase Item o la propiedad Items, y
a que pertenecen al goblin de la esquina que se enfurecerá instantáneamente y te disparará, 
ya que no cree en la propiedad compartida del código (puedes hacer que el método UpdateQuality 
y la propiedad Items estático si lo desea, lo cubriremos).

Solo para aclarar, un artículo nunca puede tener su Calidad aumentada por encima de 50, 
sin embargo, "Sulfuras" es un artículo legendario y, como tal, su Calidad es 80 y nunca cambia.

    
=end

