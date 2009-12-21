From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Subject: RE: [PATCH] ep93xx_keypad.c: cleanup and use matrix_keypad helpers
Date: Mon, 21 Dec 2009 13:27:48 -0500
Message-ID: <BD79186B4FD85F4B8E60E381CAEE19090200F172@mi8nycmail19.Mi8.com>
References: <BD79186B4FD85F4B8E60E381CAEE19090200F166@mi8nycmail19.Mi8.com> <20091221181959.GA6696@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exprod6ob113.obsmtp.com ([64.18.1.30]:53349 "HELO psmtp.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1750702AbZLUS1u convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Dec 2009 13:27:50 -0500
Content-class: urn:content-classes:message
In-Reply-To: <20091221181959.GA6696@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Monday, December 21, 2009 11:20 AM, Dmitry Torokhov wrote:
>
> Hi Hartley,
>
> On Mon, Dec 21, 2009 at 01:01:01PM -0500, H Hartley Sweeten wrote:
>> ep93xx_keypad.c: cleanup and use matrix_keypad helpers
>> 
>> 1) use struct matrix_keymap_data to supply the keymap from the platform code
>>    and use matrix_keypad_build_keymap() to initialize the keymap
>
> I;d prefer this one split out. Also, is there any in-kernel users and
> will they be converted to the new format of platform data.

I will split the patch and repost.

There are no current in-kernel users so it should not be a problem.

>> 2) namespace sanitize the local defines
>> 3) cleanup the interrupt handler to make it more understandable
>> 4) allocate the keycode matrix at run time
>
> What is the point given that the size of the keymap is still constant
> with your patch. And even if it was dynamic just stick it at the end of
> struct ep93xx_keypad as unsigned short keycodes[] and allocate in one
> shot.

No real point, I was just following the way it was done in matrix_keypad.c.

I guess it makes more sense to leave the keycode matrix as a constant.  With
the EP93XX the matrix is always 8x8 since the peripheral always scans every
row/column.  I will switch it back.

Are you ok with the interrupt handler change?

Regards,
Hartley
