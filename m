From: Didier Moens <moensd@xs4all.be>
Subject: Re: Force Feedback for Thrustmaster RGT Pro Clutch Pedal Edition
 racing wheel
Date: Wed, 24 Sep 2008 13:32:39 +0200
Message-ID: <48DA2557.2030008@xs4all.be>
References: <48CBD7B3.4070104@xs4all.be> <Pine.LNX.4.64.0809200442010.27884@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.xs4all.be ([195.144.64.135]:42701 "EHLO smtp1.evonet.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751766AbYIXLc5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Sep 2008 07:32:57 -0400
In-Reply-To: <Pine.LNX.4.64.0809200442010.27884@twin.jikos.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org
Cc: Zinx Verituse <zinx@epicsol.org>

Dear,

On 20/09/08 04:44, Jiri Kosina wrote:
> For start, running hd in debugging mode (CONFIG_HID_DEBUG and modprobing 
> 'hid' module with 'debug=2' parameter) and capturing output of a working 
> session in windows might be good steps.
>   

Thank you all (Jiri, Anssi, Jean-Philippe) for your highly valued input 
in getting this steering wheel supported.
By Jiri's request, I've retested the device with hid_debug=2 (recompiled 
kernel 2.6.26.5-27.fc8, as hid is not modularized in Fedora 8 : patch 
see below).

For brevity's sake and to not clog up the mailing list, all logs and 
generated output are available at http://www.dmbr.UGent.be/~didier/tmff/ 
; directory contents :

linux-2.6-dmn-ff2.patch : patch to enable wheel & debug messages
dmesg.out : relevant dmesg ;
messages.out : relevant messages ;
evtest.out : output for ff-utils evtest.
tmcpl/ : 3 screenshots of the Windows ThrustMaster Control Panel.


Additionally, I've run some USB snooping sessions in a native Windows 
session, with both SniffUSB, results in the sniffusb/ directory, and 
Snoopy Pro (http://sourceforge.net/projects/usbsnoop), in snoopypro/. 
Both are GPL-ed applications, and Snoopy Pro runs in Wine (nice for 
interpreting the binary logs).

I gather the snoopypro/USBLog2-forcefeedback.usblog (2370 packets) may 
be the most interesting, so I also converted the binary .usblog to 
plaintext USBLog2-forcefeedback_exp.txt for sake of convenience :

a. Sequence 1-142 (lines 1-2421) : the wheel is connected and 
autocalibrates (turns left and right up to its mechanical boundaries) ;
b. Sequence 143-663[*] (lines 2422-20133) : click button 'Properties', 
then tab 'Test Forces' (see tmcpl/ tmcpl-1.jpg and tmcpl-2.jpg) ;
c. Sequence 141/664[*]-1113[*] (lines 20134-33473) : press button-1 on 
wheel to test "Engine Start" force feedback effect (see tmcpl-3.jpg), 
force feedback works ;
d. Sequence 1114[*]-1186 (lines 33474-35954) : close Thrustmaster 
Control Panel.

([*] as packets are spuriously captured, this is a guesstimation)


Please indicate whether you might need more information ; I'm available 
for any patching and/or testing.



Best regards,

Didier

