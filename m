From: Robert van Geerenstein <info@r15n.nl>
Subject: Re: [Dell Inspiron 17R SE 7720] Synaptics touchpad recognized as
 PS/2 Generic Mouse
Date: Mon, 23 Dec 2013 19:56:31 +0100
Message-ID: <52B8875F.9060705@r15n.nl>
References: <52B87EE0.5030104@r15n.nl> <CAJiQ=7CG-C4RR7xO_W+SKai-fLKr6xutAn5L0omuLgDPhBtFHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailer01.deralte.nl ([213.154.229.52]:33646 "EHLO
	mailer01.deralte.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067Ab3LWS5X (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Dec 2013 13:57:23 -0500
In-Reply-To: <CAJiQ=7CG-C4RR7xO_W+SKai-fLKr6xutAn5L0omuLgDPhBtFHg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
Cc: linux-input@vger.kernel.org, Tommy Will <tommywill2011@gmail.com>, Justin Clift <jclift@redhat.com>

On 23-12-2013 19:47, Kevin Cernekee wrote:
> On Mon, Dec 23, 2013 at 10:20 AM, Robert van Geerenstein <info@r15n.nl> wrote:
>> My touchpad is detected as a PS/2 Generic Mouse on my Dell Inspiron 7720
>> (17R SE).
>> It only has the functionality of a generic mouse (movement, left clik, right
>> click) and no scrolling or multitouch.
> Hmm, doesn't this laptop have an ALPS Dolphin V2 touchpad (not Synaptics)?
>
> Tommy and Justin were working on this a while back.  There are a few
> patches in the list archives that you could try out.  I believe
> they're mostly ready for merging except for one remaining issue with
> the trackstick.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Hmm, looks like you're right. :/
Didn't even notice after all this time, guess back when I made the 
bugreport on launchpad I was all over the place trying to get it to work.

I'll go ahead and see if I can find anything in the archives that might 
get it to work.

Good to hear they're mostly ready for merging though.
