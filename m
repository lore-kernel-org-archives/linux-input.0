From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 6/7] thinkpad_acpi: More Carbon X1 2014 keys
Date: Mon, 23 Feb 2015 07:51:21 -0800
Message-ID: <CALCETrV5QEitQg=czkejvvxCFa77pe+1osWPc0mdHdEZyBh3Yw@mail.gmail.com>
References: <1424443477.22910.18.camel@hadess.net> <54E78AAB.2020604@mit.edu> <1424686145.28361.9.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424686145.28361.9.camel@hadess.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Darren Hart <dvhart@infradead.org>, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>
List-Id: linux-input@vger.kernel.org

On Mon, Feb 23, 2015 at 2:09 AM, Bastien Nocera <hadess@hadess.net> wrote:
> On Fri, 2015-02-20 at 11:27 -0800, Andy Lutomirski wrote:
>> On 02/20/2015 06:44 AM, Bastien Nocera wrote:
>> > +           KEY_MICCANCEL_MODE,  /* Microphone cancellation */
>>
>> What's this?  We already have KEY_MICMUTE.  Is this different?  If so,
>> can you improve the comment a bit?
>
> I don't think the comment needs improving. This is the device driver
> part of the patch series. If comment was required, it would in the
> commit adding the keycode to input.h. We're discussing that with Dmitry.
>

Right, sorry, I replied to the wrong patch.

>> The answer may be obvious to anyone who has an awful X1 carbon gen 2
>> keyboard, but these KEY_XYZ defines should IMO be clear enough that even
>> people without the hardware can figure out what's going on.
>
> I'll make sure to link this in the input.h patch:
> http://www.lenovo.com/shop/americas/content/user_guides/x1carbon_2_ug_en.pdf
>
> In any case, it doesn't look like this particular keycode will make it.
>

Oh, it's microphone *noise* cancellation.  I assumed it somehow
cancelled the microphone, and I was a bit confused.

If the keycode ends up getting added, could you add the word "noise" somewhere?

Thanks,
Andy
