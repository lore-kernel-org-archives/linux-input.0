From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: [PATCH 2/2] hid-ntrig: calibration
Date: Thu, 24 Mar 2011 12:52:25 -0400
Message-ID: <4D8B76C9.7000601@seas.upenn.edu>
References: <1299829072-19489-1-git-send-email-rafi@seas.upenn.edu> <1299829072-19489-2-git-send-email-rafi@seas.upenn.edu> <20110321171550.GA4602@polaris.bitmath.org> <alpine.LNX.2.00.1103241531130.19969@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1103241531130.19969@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, micki@n-trig.com, chatty@enac.fr, dmitry.torokhov@gmail.com
List-Id: linux-input@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 03/24/11 10:32, Jiri Kosina wrote:
> On Mon, 21 Mar 2011, Henrik Rydberg wrote:
> 
>>> Adding a function to tell the device to run its calibration routine.
>>> A number written to the sysfs specifies the duration of the calibration
>>> in milliseconds
>>>
>>> Signed-off-by: Rafi Rubin <rafi@seas.upenn.edu>
>>> ---
>>
>> This is great functionality, and from what it seems, it works. However, 
>> the poking at the usb layer makes me wonder if there is another way... 
>> Jiri? Dmitry? Awaiting answers from someone more knowledgeable, please 
>> find some comments inline.
> 
> Actually, let me put it another way -- is there any reason not to have 
> this as a functionality provided by HID core code (with driver registering 
> callbacks if they want to provide calibration functionality)?
> 
> Thanks,
> 

I thought Henrik was asking about an alternative to the raw usb calls, something
like usbhid_submit_report that would satisfy the needs of this calibration routine.


As for a standard hid calibration interface, I like the idea.

Rafi
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBAgAGBQJNi3bIAAoJEPILXytRLnK2HO4QAJQtrlG2PB4mERWQ5gGkoJTT
qYoQiek1RJylFb/wJlzVajMtjQ+kFc98N3faSmIvbrsXwYZfEYZQxlnS/463EYTw
vnYgSFTqj7+mSwrQMX4civJTZJPfbLGJD1wvzBBq8cAhPonedn2z3a8gU30AdPc3
Dc/Ht+dHgOomzdkfjn77GTGYyiGDZwl0mYPuh6nhOBjhOmUDErRg+4yZQ1/wfaJr
2jEty0hEXwwkD1iqgDPmIqiEIZ7r5RkGCOWUsi+0rMeIiobaUxk281c0aZ295BFT
PhGbiqzkASp+a7TpVpdnHFCofmCSinb00gpbVbeqtuUsauNuUgVVij/lPe0vxTNB
ivW5V3MYgceDCDkAR+p3nsu3lvYv6cWqbxFQ5pzUIkxsnEfUowpjWLoSQl3Fmym0
IbKYs4ueAgI3G7gw+xQfjnJX53DmAbKoXoQAesSEwzAXCAz1BSZih2ORPTGM68Pd
eDLk729/6RAFZVmnwgNlEfx68vaxmhrHK0GDod2k/V/TRsSBG42I15G8p7Xu359m
cQyNUraMDFfHvC71Y6ZIL3tK0h2LXjsvd1Z17HzAROFWm2tNSSjg/xaVJ0ftDot3
cIM86Na/ysGwdKRB1xdElPBf8rb+vjVPDcv4v3PJTd9GbgN6MoRl1RWtv+XwnW/A
VzPpDqxYbAW9hewHbzSW
=KW05
-----END PGP SIGNATURE-----
