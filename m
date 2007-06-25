From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: Anything against a new EV_SW SW_RADIO event ?
Date: Mon, 25 Jun 2007 00:22:14 -0400
Message-ID: <200706250022.15244.dtor@insightbb.com>
References: <20070624105514.GA8909@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070624105514.GA8909@khazad-dum.debian.net>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-input@atrey.karlin.mff.cuni.cz, ibm-acpi-devel@lists.sourceforge.net, Ivo van Doorn <ivdoorn@gmail.com>, Richard Hughes <hughsient@gmail.com>
List-Id: linux-input@vger.kernel.org

Hi Henrique,

On Sunday 24 June 2007 06:55, Henrique de Moraes Holschuh wrote:
> Dmitry,
> 
> Could you ACK the attached patch?  I am about to send in code that would
> benefit a damn great deal from it (thinkpad-acpi support for the
> T60/X60/newer radio-kill slider switch)...  So I thought it would be best to
> check with you first if I can have an EV_SW SW_RADIO...
> 

Adding SW_RADIO would be fine. My only question is if SW_ARDIO is enough or
if we would need SW_WIFI/SW_BLUETOOTH/SW_ETC down the road...

-- 
Dmitry
