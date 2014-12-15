From: Amordea Whiteoak <amordea@gmail.com>
Subject: Re: PROBLEM: [HP Stream Notebook - 11-d010nr] clickpad malfunctions
 after performing a hardware click
Date: Mon, 15 Dec 2014 15:05:04 -0500
Message-ID: <CALmnu0a_HmgJXa9aYbCpyRhAb5h_FrLyhVUeeojMJa0tPUTHTg@mail.gmail.com>
References: <CALmnu0aD9ys4+QZ+gtdNe61q23A3e6MPq+DSD-Q+NcJoWksWkQ@mail.gmail.com>
	<CAN+gG=EXmDcuNvifZKqLLTxew9ji2FW3jx7i8ThqozE1cg_e6A@mail.gmail.com>
	<CALmnu0Y+n0qGs4jgC=YGKRbBSyVB5B4s_Oafsmvbk6M=67okuw@mail.gmail.com>
	<CAN+gG=E+8277zg3LLW-eFWZb8bNyU_Umf9M2w6+t7Y3sSkkSFg@mail.gmail.com>
	<CALmnu0bPLi4skqUxvjd9DWrZJysvqX-+nxNHdx5APGsoNZsnKA@mail.gmail.com>
	<CAN+gG=Emz8r=17OpUETpVQyjCMDMX=aNEFFHZo3ivGS=xTZHXA@mail.gmail.com>
	<CALmnu0agW-mN9RON1FT9DCxE9POiwS2Jhj7hXZaW+6escc7OGw@mail.gmail.com>
	<CALmnu0aMX8RuDJFozCwP6GmP11Uep=R6bc0EqPYzBknwpHBmpA@mail.gmail.com>
	<CAN+gG=E=3kG9t9XTNe0X1kFumdkQ3CfM-ViXnOBGThmyJDNJ4g@mail.gmail.com>
	<CALmnu0Yg1vd4FOD5vtW39cbbcsRYiPuiiMD0A+obLyrkvKO+jA@mail.gmail.com>
	<CALmnu0Y0kvU-yqrKvNAQmjUgFJQ-v0NESyV6o_=CuVzc2dx=YQ@mail.gmail.com>
	<CAN+gG=GucHKyGB0Z=qP+G2KSej0yoVe3vpa3AzRbBDeP2jw9Qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a11c3bc201f54ac050a46c20d
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:50686 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728AbaLOUFF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Dec 2014 15:05:05 -0500
Received: by mail-pd0-f169.google.com with SMTP id z10so12337215pdj.14
        for <linux-input@vger.kernel.org>; Mon, 15 Dec 2014 12:05:04 -0800 (PST)
In-Reply-To: <CAN+gG=GucHKyGB0Z=qP+G2KSej0yoVe3vpa3AzRbBDeP2jw9Qg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>, Andrew Duggan <aduggan@synaptics.com>

--001a11c3bc201f54ac050a46c20d
Content-Type: text/plain; charset=UTF-8

> Strictly speaking, there is no right click button on clickpads. We
> emulate one with the software buttons in Xorg.
> IIRC, there were some "workarounds" in your original bugs which
> consist in disabling the software buttons area. Can you make sure that
> there is no left over from this?

I learn new things about clickpads every day. :)

To my knowledge, those configurations changes should reset upon reboot
and I never committed any of those lines to any of my startup files.
So we should be good there, I think. Just in case, I am enclosing the
output of my synclient -l, which should be the default configuration.

> If this still doesn't work, we wil need to check that the X and Y
> ranges reported by your clickpad are accurate and that the software
> buttons are properly activated.

I don't know the testing methodology to use to provide positioning
data for my trackpad, but let me know if you need that and how you
want me to get it and I will be happy to provide.

Thank you!

--001a11c3bc201f54ac050a46c20d
Content-Type: application/octet-stream; name="synclient.list"
Content-Disposition: attachment; filename="synclient.list"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_i3q9h3vm0

UGFyYW1ldGVyIHNldHRpbmdzOgogICAgTGVmdEVkZ2UgICAgICAgICAgICAgICAgPSAxNjEKICAg
IFJpZ2h0RWRnZSAgICAgICAgICAgICAgID0gMzg0OAogICAgVG9wRWRnZSAgICAgICAgICAgICAg
ICAgPSAxMjMKICAgIEJvdHRvbUVkZ2UgICAgICAgICAgICAgID0gMjE0NAogICAgRmluZ2VyTG93
ICAgICAgICAgICAgICAgPSAyNQogICAgRmluZ2VySGlnaCAgICAgICAgICAgICAgPSAzMAogICAg
TWF4VGFwVGltZSAgICAgICAgICAgICAgPSAxODAKICAgIE1heFRhcE1vdmUgICAgICAgICAgICAg
ID0gMjAyCiAgICBNYXhEb3VibGVUYXBUaW1lICAgICAgICA9IDE4MAogICAgU2luZ2xlVGFwVGlt
ZW91dCAgICAgICAgPSAxODAKICAgIENsaWNrVGltZSAgICAgICAgICAgICAgID0gMTAwCiAgICBF
bXVsYXRlTWlkQnV0dG9uVGltZSAgICA9IDc1CiAgICBFbXVsYXRlVHdvRmluZ2VyTWluWiAgICA9
IDI4MgogICAgRW11bGF0ZVR3b0Zpbmdlck1pblcgICAgPSA3CiAgICBWZXJ0U2Nyb2xsRGVsdGEg
ICAgICAgICA9IDkyCiAgICBIb3JpelNjcm9sbERlbHRhICAgICAgICA9IDkyCiAgICBWZXJ0RWRn
ZVNjcm9sbCAgICAgICAgICA9IDEKICAgIEhvcml6RWRnZVNjcm9sbCAgICAgICAgID0gMAogICAg
Q29ybmVyQ29hc3RpbmcgICAgICAgICAgPSAwCiAgICBWZXJ0VHdvRmluZ2VyU2Nyb2xsICAgICA9
IDEKICAgIEhvcml6VHdvRmluZ2VyU2Nyb2xsICAgID0gMAogICAgTWluU3BlZWQgICAgICAgICAg
ICAgICAgPSAxCiAgICBNYXhTcGVlZCAgICAgICAgICAgICAgICA9IDEuNzUKICAgIEFjY2VsRmFj
dG9yICAgICAgICAgICAgID0gMC4wNDM0NTk0CiAgICBUb3VjaHBhZE9mZiAgICAgICAgICAgICA9
IDAKICAgIExvY2tlZERyYWdzICAgICAgICAgICAgID0gMAogICAgTG9ja2VkRHJhZ1RpbWVvdXQg
ICAgICAgPSA1MDAwCiAgICBSVENvcm5lckJ1dHRvbiAgICAgICAgICA9IDIKICAgIFJCQ29ybmVy
QnV0dG9uICAgICAgICAgID0gMwogICAgTFRDb3JuZXJCdXR0b24gICAgICAgICAgPSAwCiAgICBM
QkNvcm5lckJ1dHRvbiAgICAgICAgICA9IDAKICAgIFRhcEJ1dHRvbjEgICAgICAgICAgICAgID0g
MQogICAgVGFwQnV0dG9uMiAgICAgICAgICAgICAgPSAzCiAgICBUYXBCdXR0b24zICAgICAgICAg
ICAgICA9IDAKICAgIENsaWNrRmluZ2VyMSAgICAgICAgICAgID0gMQogICAgQ2xpY2tGaW5nZXIy
ICAgICAgICAgICAgPSAxCiAgICBDbGlja0ZpbmdlcjMgICAgICAgICAgICA9IDAKICAgIENpcmN1
bGFyU2Nyb2xsaW5nICAgICAgID0gMAogICAgQ2lyY1Njcm9sbERlbHRhICAgICAgICAgPSAwLjEK
ICAgIENpcmNTY3JvbGxUcmlnZ2VyICAgICAgID0gMAogICAgQ2lyY3VsYXJQYWQgICAgICAgICAg
ICAgPSAwCiAgICBQYWxtRGV0ZWN0ICAgICAgICAgICAgICA9IDAKICAgIFBhbG1NaW5XaWR0aCAg
ICAgICAgICAgID0gMTAKICAgIFBhbG1NaW5aICAgICAgICAgICAgICAgID0gMjAwCiAgICBDb2Fz
dGluZ1NwZWVkICAgICAgICAgICA9IDIwCiAgICBDb2FzdGluZ0ZyaWN0aW9uICAgICAgICA9IDUw
CiAgICBQcmVzc3VyZU1vdGlvbk1pblogICAgICA9IDMwCiAgICBQcmVzc3VyZU1vdGlvbk1heFog
ICAgICA9IDE2MAogICAgUHJlc3N1cmVNb3Rpb25NaW5GYWN0b3IgPSAxCiAgICBQcmVzc3VyZU1v
dGlvbk1heEZhY3RvciA9IDEKICAgIFJlc29sdXRpb25EZXRlY3QgICAgICAgID0gMQogICAgR3Jh
YkV2ZW50RGV2aWNlICAgICAgICAgPSAwCiAgICBUYXBBbmREcmFnR2VzdHVyZSAgICAgICA9IDEK
ICAgIEFyZWFMZWZ0RWRnZSAgICAgICAgICAgID0gMAogICAgQXJlYVJpZ2h0RWRnZSAgICAgICAg
ICAgPSAwCiAgICBBcmVhVG9wRWRnZSAgICAgICAgICAgICA9IDAKICAgIEFyZWFCb3R0b21FZGdl
ICAgICAgICAgID0gMAogICAgSG9yaXpIeXN0ZXJlc2lzICAgICAgICAgPSAyMwogICAgVmVydEh5
c3RlcmVzaXMgICAgICAgICAgPSAyMwogICAgQ2xpY2tQYWQgICAgICAgICAgICAgICAgPSAwCg==
--001a11c3bc201f54ac050a46c20d--
