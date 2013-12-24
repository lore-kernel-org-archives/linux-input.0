From: Robert van Geerenstein <info@r15n.nl>
Subject: Re: [Dell Inspiron 17R SE 7720] Synaptics touchpad recognized as
 PS/2 Generic Mouse
Date: Tue, 24 Dec 2013 10:45:54 +0100
Message-ID: <52B957D2.9000406@r15n.nl>
References: <52B87EE0.5030104@r15n.nl>	<CAJiQ=7CG-C4RR7xO_W+SKai-fLKr6xutAn5L0omuLgDPhBtFHg@mail.gmail.com>	<52B8875F.9060705@r15n.nl> <CA+F6ckNU9FHSMQfF9Q640QDa1rmsiR5-ZCCM6m7iPMydjBiSwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailer01.deralte.nl ([213.154.229.52]:36690 "EHLO
	mailer01.deralte.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831Ab3LXJqO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Dec 2013 04:46:14 -0500
In-Reply-To: <CA+F6ckNU9FHSMQfF9Q640QDa1rmsiR5-ZCCM6m7iPMydjBiSwg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tommy Will <tommywill2011@gmail.com>
Cc: Kevin Cernekee <cernekee@gmail.com>, linux-input@vger.kernel.org, Justin Clift <jclift@redhat.com>

Hi Tommy,

Will do, thank you. Let me know when it's available so I can test it.
Is there a manual on how and what to test?
I'm pretty much new with all of this, so any info would be awesome.

Yesterday I did find this post: 
http://linuxg.net/ubuntu-13-04-touchpad-option-does-not-exist-error-fix/
After doing that I was able to use multitouch scroll and double tap with 
2 fingers, but it's not that smooth yet.
The touchpad is now added as AlpsPS/2 ALPS GlidePoint



On 24-12-2013 2:04, Tommy Will wrote:
> Hi Kevin,
>
> Thanks for you following this issue.
> About the trackstick issue, although I still have not got the
> feedback, I'd start preparing the new patch since it
> does not have problem as far as my self testing.
>
> Hi Robert,
>
> Please wait and try my new patch later. Hopes it could fix your problem.
>
> --
> Best Regards,
> Tommy
>
> 2013/12/24 Robert van Geerenstein <info@r15n.nl>:
>> On 23-12-2013 19:47, Kevin Cernekee wrote:
>>> On Mon, Dec 23, 2013 at 10:20 AM, Robert van Geerenstein <info@r15n.nl>
>>> wrote:
>>>> My touchpad is detected as a PS/2 Generic Mouse on my Dell Inspiron 7720
>>>> (17R SE).
>>>> It only has the functionality of a generic mouse (movement, left clik,
>>>> right
>>>> click) and no scrolling or multitouch.
>>> Hmm, doesn't this laptop have an ALPS Dolphin V2 touchpad (not Synaptics)?
>>>
>>> Tommy and Justin were working on this a while back.  There are a few
>>> patches in the list archives that you could try out.  I believe
>>> they're mostly ready for merging except for one remaining issue with
>>> the trackstick.
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-input" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>> Hmm, looks like you're right. :/
>> Didn't even notice after all this time, guess back when I made the bugreport
>> on launchpad I was all over the place trying to get it to work.
>>
>> I'll go ahead and see if I can find anything in the archives that might get
>> it to work.
>>
>> Good to hear they're mostly ready for merging though.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

