From: David B Harris <dbharris@eelf.ddts.net>
Subject: Re: Synaptics touchpad hidden in a keyboard
Date: Fri, 28 May 2010 09:38:11 -0400
Message-ID: <1275053891.11891.1.camel@willow.eelf.ddts.net>
References: <20100528021446.GN4712@oak.eelf.ddts.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from defiant.circainformation.com ([64.5.53.35]:40122 "EHLO
	defiant.circainformation.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754318Ab0E1NiO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 May 2010 09:38:14 -0400
In-Reply-To: <20100528021446.GN4712@oak.eelf.ddts.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

On Thu, 2010-05-27 at 22:14 -0400, David B Harris wrote:
> I've attached the relevant sections of 'lsusb -vvv' and the file
> /proc/bus/input/devices, as well as a highly-compressed, low-resolution
> picture of the back of the touchpad itself [3] (which clearly shows
> "Synaptics" on it, incidentally). I'm suspecting that the controller in the
> keyboard hides the touchpad.

Something I had neglected to mention; 'tpconfig -i' does at least
partially recognize it:

        [ dbharris@willow: ~/ ]$ sudo tpconfig -i
        Found Synaptics Touchpad.
        Firmware: 8.96 (multiple-byte mode).
        Sensor type: unknown (0).
        Geometry: rectangular/landscape/up.
        Packets: absolute, 80 packets per second.
        Corner taps disabled;           no tap gestures.
        Edge motion: none.
        Z threshold: 6 of 7.
        2 button mode; corner tap is right button click.
        [ dbharris@willow: ~/ ]$ 

Thanks again,

Dave

-- 
     Arguing with an engineer is like wrestling with a pig in mud.
           After a while, you realise the pig is enjoying it.

                   OpenPGP v4 key ID: 4096R/59DDCB9F
    Fingerprint: CC53 F124 35C0 7BC2 58FE  7A3C 157D DFD9 59DD CB9F
                     Retrieve from subkeys.pgp.net

