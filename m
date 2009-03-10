From: Antti Palosaari <crope@iki.fi>
Subject: Re: [PATCH] DVB-USB: correct the comment about KEY_SLEEP
Date: Tue, 10 Mar 2009 12:31:52 +0200
Message-ID: <49B64198.6050201@iki.fi>
References: <1235992429.3858.58.camel@hughsie-work.lan>	 <20090302112400.GA2356@khazad-dum.debian.net>	 <1236164049.3936.17.camel@hughsie-work.lan> <1236164977.3936.30.camel@hughsie-work.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <1236164977.3936.30.camel@hughsie-work.lan>
Sender: linux-media-owner@vger.kernel.org
To: Richard Hughes <hughsient@gmail.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Peter Hutterer <peter.hutterer@redhat.com>, mjg <mjg@redhat.com>, linux-input <linux-input@vger.kernel.org>, Matthias Clasen <mclasen@redhat.com>, linux-media@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Richard Hughes wrote:
> On Wed, 2009-03-04 at 10:54 +0000, Richard Hughes wrote:
>> On Mon, 2009-03-02 at 08:24 -0300, Henrique de Moraes Holschuh wrote:
>>> FWIW, I think it is a good idea, and I'd take patches for
>>> thinkpad-acpi.
>> Patch attached for thinkpad-acpi. KEY_HIBERNATE is already in
>> linux-next, but has not yet been pushed to master. Please review,
>> thanks.
> 
> Antti, I've included a fix to the Afatech AF9015 DVB-T USB2.0 receiver
> header file. It corrects the comment about KEY_SLEEP. Please review.

It is not correct. Comment "Hibernate" for that button comes from the 
remote controller, where "Z^z" is printed to the top of the button and 
"Hibernate" below the button. Replacing KEY_SLEEP with KEY_HIBERNATE 
seems to be correct solution for me.

regards
Antti
-- 
http://palosaari.fi/
