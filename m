From: David Christen <davidchristen@gmail.com>
Subject: Re: Enable addition function keys
Date: Wed, 25 May 2011 11:48:39 +0200
Message-ID: <BANLkTikHKZSqxTu3psHWwaBwiAkWKLhY-Q@mail.gmail.com>
References: <000001cc1403$1e0ede10$5a2c9a30$@com>
	<20110524062256.GA20829@core.coreip.homeip.net>
	<BANLkTinh4Ssnv16t9wp79D82XekiQMZguQ@mail.gmail.com>
	<BANLkTikFxR_xzZV6WNce+HBDVwc5QZc9yQ@mail.gmail.com>
	<20110524164931.GA16841@core.coreip.homeip.net>
	<BANLkTikH1kzGVqnqF=9uyZHRkWEK3ErURA@mail.gmail.com>
	<20110524175238.GA16908@core.coreip.homeip.net>
	<20110524180259.GG2622@nautilus.holoscopio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53843 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753315Ab1EYJsk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 May 2011 05:48:40 -0400
Received: by mail-wy0-f174.google.com with SMTP id 21so5625671wya.19
        for <linux-input@vger.kernel.org>; Wed, 25 May 2011 02:48:39 -0700 (PDT)
In-Reply-To: <20110524180259.GG2622@nautilus.holoscopio.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Tue, May 24, 2011 at 8:03 PM, Thadeu Lima de Souza Cascardo
<cascardo@holoscopio.com> wrote:
> On Tue, May 24, 2011 at 10:52:38AM -0700, Dmitry Torokhov wrote:
>> On Tue, May 24, 2011 at 07:39:22PM +0200, David Christen wrote:
>> >
>> > Yes, you were right. Please find the corrected file attached.
>> >
>> > But it seems that the behavior is exactly the same.
>> >
>> > The kernel I use is 2.6.33 . It's a debian distro running on a risc processor.
>>
>> I am afraid you need 2.6.38. Or you'll have to backport the following
>> commits:
>>
>> 8613e4c Input: add support for large scancodes
>> ab4e019 Input: define separate EVIOCGKEYCODE_V2/EVIOCSKEYCODE_V2
>> de391d1 Input: fix typo in keycode validation supporting large scancodes
>> a0bf0ea Input: hid-input - switch to using new keycode interface
>> f5854fa Input: hid-input - allow mapping unknown usages
>>
>> --
>> Dmitry
>
> Perhaps, he could try using hidraw interface. Would it be OK for you,
> David? Since you said you are only getting these key events and sending
> them through a serial interface, and I'd say your device portability
> does not include non-HID devices right now, this should solve the
> problem without the need for a kernel upgrade.
>
> Regards,
> Cascardo.
>

Dear Cascardo and Dmitry,

Thank you for the hint with the hidraw. I was briefly looking at this
in the beginning of the project, but I found it was a bit too raw for
my purpose. Well, I was wrong...

Based on the example in the Documentation
(http://ns3.spinics.net/lists/linux-input/msg14216.html), together
with the patch for HIDIOCSFEATURE
(http://choon.net/forum/read.php?21,19545) and the same for
HIDIOCGRAWNAME I was able to first write a small test program and
later last night to actually build it into my software project.

Thank you very much the effort in helping me with this.

Take care,
David
