# encoding: utf-8

module SmsManager
  class SendingError < ::Exception

    attr_reader :options, :code

    def initialize(options, body)
      @code = body.split('|').last.to_i
      @options = options
    end

    def message
      if code.between(900,999)
        CODE_9XX
      elsif CODES[code]
        CODES[code]
      else
        'Neznámý chybový kód'
      end
    end

    private

    CODES = {
      101 => 'Neexistující data požadavku (chybí XMLDATA parametr u XML API)',
      102 => 'Metoda neexistuje',
      103 => 'Neplatné uživatelské jméno nebo heslo',
      104 => 'Neplatný parametr gateway',
      105 => 'Nedostatek kreditu pro prepaid',
      201 => 'Žádná platná telefonní čísla v požadavku',
      202 => 'Text zprávy neexistuje nebo je příliš dlouhý',
      203 => 'Neplatný parametr sender (odesílatele nejprve nastavte ve webovém rozhraní)'
    }
    CODE_9XX = 'Systémová chyba (informujte se na support@smsmanager.cz)'
  end
end
