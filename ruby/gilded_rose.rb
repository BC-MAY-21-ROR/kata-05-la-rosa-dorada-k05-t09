
class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
      @items.each(&method(:update))
      self
  end

  def update(item)
    if item.name == "Sulfuras, Hand of Ragnaros"
      SulfurasUpdater.new(item).update
    elsif item.name == "Backstage passes to a TAFKAL80ETC concert"
      BackstagePassesUpdater.new(item).update
    elsif item.name == "Aged Brie"
      AgedBrieUpdater.new(item).update
    elsif item.name == "Conjured Mana Cake"
      ConjuredUpdater.new(item).update
    else
      BasicItemUpdater.new(item).update
    end
    nil
  end

  class SulfurasUpdater
    attr_reader :item

    def initialize(item)
      @item = item
    end

    def update
    end
  end

  class BasicItemUpdater
    attr_reader :item

    def initialize(item)
      @item = item
    end

    def update
      if item.quality > 0
        item.quality -= 1
      end
      item.sell_in -= 1
      if item.sell_in < 0
        if item.quality > 0
          item.quality -= 1
        end
      end
    end
  end

  class ConjuredUpdater
    attr_reader :item
    def initialize (item)
      @item = item
    end
    def update
    if item.quality > 0
      item.quality /= 2
    end
    item.sell_in -= 1
    end
  end

  class AgedBrieUpdater
    attr_reader :item

    def initialize(item)
      @item = item
    end

    def update
      if item.quality < 50
        item.quality += 1
      end
      item.sell_in -= 1
      if item.sell_in < 0
        if item.quality < 50
          item.quality += 1
        end
      end
    end
  end

  class BackstagePassesUpdater
    attr_reader :item

    def initialize(item)
      @item = item
    end

    def update
      if item.quality < 50
        item.quality += 1
        if item.sell_in < 11
          if item.quality < 50
            item.quality += 1
          end
        end
        if item.sell_in < 6
          if item.quality < 50
            item.quality += 1
          end
        end
      end
      item.sell_in -= 1
      if item.sell_in < 0
        item.quality -= item.quality
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

Bienvenido al equipo de Gilded Rose. Como quizá sabes, somos una pequeña posada 
ubicada estratégicamente en una prestigiosa ciudad, atendida por la amable Allison. 
También compramos y vendemos mercadería de alta calidad. Por desgracia, nuestra mercadería 
va bajando de calidad a medida que se aproxima la fecha de venta.

Tenemos un sistema instalado que actualiza automáticamente el inventario. 
Este sistema fue desarrollado por un muchacho con poco sentido común llamado Leeroy, 
que ahora se dedica a nuevas aventuras. Tu tarea es agregar una nueva característica 
al sistema para que podamos comenzar a vender una nueva categoría de items.

Descripción preliminar
Pero primero, vamos a introducir el sistema:

Todos los artículos (Item) tienen una propiedad sellIn que denota el número de días que tenemos para venderlo
Todos los artículos tienen una propiedad quality que denota cúan valioso es el artículo
Al final de cada día, nuestro sistema decrementa ambos valores para cada artículo mediante el método updateQuality
Bastante simple, ¿no? Bueno, ahora es donde se pone interesante:

Una vez que ha pasado la fecha recomendada de venta, la calidad se degrada al doble de velocidad
La calidad de un artículo nunca es negativa
El "Queso Brie envejecido" (Aged brie) incrementa su calidad a medida que se pone viejo
Su calidad aumenta en 1 unidad cada día
luego de la fecha de venta su calidad aumenta 2 unidades por día
La calidad de un artículo nunca es mayor a 50
El artículo "Sulfuras" (Sulfuras), siendo un artículo legendario, no modifica su fecha de venta ni se degrada en calidad
Una "Entrada al Backstage", como el queso brie, incrementa su calidad a medida que la fecha de venta se aproxima
si faltan 10 días o menos para el concierto, la calidad se incrementa en 2 unidades
si faltan 5 días o menos, la calidad se incrementa en 3 unidades
luego de la fecha de venta la calidad cae a 0
El requerimiento
Hace poco contratamos a un proveedor de artículos conjurados mágicamente. Esto requiere una actualización 
del sistema:

Los artículos conjurados degradan su calidad al doble de velocidad que los normales
Siéntete libre de realizar cualquier cambio al mensaje updateQuality y agregar el 
código que sea necesario, mientras que todo siga funcionando correctamente. Sin embargo, 
no alteres el objeto Item ni sus propiedades ya que pertenecen al goblin que está en ese rincón, 
que en un ataque de ira te va a liquidar de un golpe porque no cree en la cultura de código compartido.

Notas finales
Para aclarar: un artículo nunca puede tener una calidad superior a 50, sin embargo las Sulfuras siendo un 
artículo legendario posee una calidad inmutable de 80.

-------------------------------------------------------------------------
    
=end

