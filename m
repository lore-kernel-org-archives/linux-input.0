From: Tommy Will <tommywill2011@gmail.com>
Subject: Re: [Dell Inspiron 17R SE 7720] Synaptics touchpad recognized as PS/2
 Generic Mouse
Date: Tue, 24 Dec 2013 09:04:36 +0800
Message-ID: <CA+F6ckNU9FHSMQfF9Q640QDa1rmsiR5-ZCCM6m7iPMydjBiSwg@mail.gmail.com>
References: <52B87EE0.5030104@r15n.nl>
	<CAJiQ=7CG-C4RR7xO_W+SKai-fLKr6xutAn5L0omuLgDPhBtFHg@mail.gmail.com>
	<52B8875F.9060705@r15n.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:48621 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753341Ab3LXBEi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Dec 2013 20:04:38 -0500
Received: by mail-lb0-f173.google.com with SMTP id z5so2591908lbh.18
        for <linux-input@vger.kernel.org>; Mon, 23 Dec 2013 17:04:37 -0800 (PST)
In-Reply-To: <52B8875F.9060705@r15n.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Robert van Geerenstein <info@r15n.nl>
Cc: Kevin Cernekee <cernekee@gmail.com>, linux-input@vger.kernel.org, Justin Clift <jclift@redhat.com>

Hi Kevin,

Thanks for you following this issue.
About the trackstick issue, although I still have not got the
feedback, I'd start preparing the new patch since it
does not have problem as far as my self testing.

Hi Robert,

Please wait and try my new patch later. Hopes it could fix your problem.

--
Best Regards,
Tommy

2013/12/24 Robert van Geerenstein <info@r15n.nl>:
> On 23-12-2013 19:47, Kevin Cernekee wrote:
>>
>> On Mon, Dec 23, 2013 at 10:20 AM, Robert van Geerenstein <info@r15n.nl>
>> wrote:
>>>
>>> My touchpad is detected as a PS/2 Generic Mouse on my Dell Inspiron 7720
>>> (17R SE).
>>> It only has the functionality of a generic mouse (movement, left clik,
>>> right
>>> click) and no scrolling or multitouch.
>>
>> Hmm, doesn't this laptop have an ALPS Dolphin V2 touchpad (not Synaptics)?
>>
>> Tommy and Justin were working on this a while back.  There are a few
>> patches in the list archives that you could try out.  I believe
>> they're mostly ready for merging except for one remaining issue with
>> the trackstick.
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-input" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> Hmm, looks like you're right. :/
> Didn't even notice after all this time, guess back when I made the bugreport
> on launchpad I was all over the place trying to get it to work.
>
> I'll go ahead and see if I can find anything in the archives that might get
> it to work.
>
> Good to hear they're mostly ready for merging though.
