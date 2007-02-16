From: "STenyaK (Bruno Gonzalez)" <stenyak@gmail.com>
Subject: Re: [PATCH] Added device to hid-ff
Date: Fri, 16 Feb 2007 16:20:38 +0100
Message-ID: <op.tnuhfeu9a64tfs@localhost>
References: <38b3b7c0702151056m7c396952j81199783f654bf7a@mail.gmail.com> <op.tns2alf2a64tfs@localhost> <d120d5000702151142l5dca88f7nc71f58473fa27040@mail.gmail.com> <d120d5000702151146p417bd326wd4c212015bf77f25@mail.gmail.com> <e35f7a1d0702160205m6ecb4460ja3d4af0a35fd042f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
Content-Transfer-Encoding: Quoted-Printable
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <e35f7a1d0702160205m6ecb4460ja3d4af0a35fd042f@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Valentin Zagura <puthre@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: johann deneux <johann.deneux@gmail.com>, linux-input <linux-input@atrey.karlin.mff.cuni.cz>
List-Id: linux-input@vger.kernel.org

On Fri, 16 Feb 2007 11:05:41 +0100, Valentin Zagura <puthre@gmail.com>  =

wrote:
> Here is what I found on the net, maybe it will clear things out:
> http://siv.mysite.wanadoo-members.co.uk/downloads/usbdevs.txt
>
> 046D:C294=3DLogitech Driving Force USB (HID)
> 046D:C294:2000=3DLogitech Driving Force EX USB (HID)
> 046D:C294:2100=3DLogitech Formula Force RX USB (HID)
> 046D:C294:2200=3DLogitech Driving Force RX USB (HID)

My wheel doesn't appear there. It's a new model (just a few months old).=

This is the whole usbview output:

---------------------------------------------------------------------
G25 Racing Wheel
Speed: 12Mb/s (full)
USB Version:  2.00
Device Class: 00(>ifc )
Device Subclass: 00
Device Protocol: 00
Maximum Default Endpoint Size: 16
Number of Configurations: 1
Vendor Id: 046d
Product Id: c294
Revision Number: 12.22

Config Number: 1
	Number of Interfaces: 1
	Attributes: 80
	MaxPower Needed:  80mA

	Interface Number: 0
		Name: usbhid
		Alternate Number: 0
		Class: 03(HID  )
		Sub Class: 0
		Protocol: 0
		Number of Endpoints: 2

			Endpoint Address: 81
			Direction: in
			Attribute: 3
			Type: Int.
			Max Packet Size: 8
			Interval: 10ms

			Endpoint Address: 01
			Direction: out
			Attribute: 3
			Type: Int.
			Max Packet Size: 8
			Interval: 10ms
---------------------------------------------------------------------


-- =

Saludos,
     STenyaK

_______________________________________________
Site:   http://1ksurvivor.homeip.net  <1kSurvivor>
         http://motorsport-sim.org     <Motorsport>
         http://kwh.iespana.es         <KuantikalWareHouse>
         http://emuletutorial.info     <EmuleTutorial>
ICQ:    153709484
Mail:   stenyak AT gmail DOT net
