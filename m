From: Tommy Will <tommywill2011@gmail.com>
Subject: Re: [PATCH v4 1/1] Input: Improve the performance of alps
 v5-protocol's touchpad
Date: Wed, 23 Oct 2013 21:56:47 +0800
Message-ID: <CA+F6ckMbXk+2ze2HRx+Wb+YoYoNMOp-Py7JtWdnec9dEVzpaXA@mail.gmail.com>
References: <1382355711-3211-1-git-send-email-yunkang.tang@cn.alps.com>
	<20131023122954.2d63b0e85fd963dabde574f4@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f48.google.com ([74.125.83.48]:63020 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163Ab3JWN4s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Oct 2013 09:56:48 -0400
Received: by mail-ee0-f48.google.com with SMTP id e50so414611eek.21
        for <linux-input@vger.kernel.org>; Wed, 23 Oct 2013 06:56:47 -0700 (PDT)
In-Reply-To: <20131023122954.2d63b0e85fd963dabde574f4@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Justin Clift <jclift@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kevin Cernekee <cernekee@gmail.com>, david turvene <dturvene@dahetral.com>, linux-input@vger.kernel.org, Niels de Vos <ndevos@redhat.com>, Yunkang Tang <yunkang.tang@cn.alps.com>

Hi Justin, Niels & All Fedora Community members,

Thank you so much for your help !

Best Regards
Tommy Will

2013/10/23 Justin Clift <jclift@redhat.com>:
> On Mon, 21 Oct 2013 19:41:50 +0800
> Yunkang Tang <tommywill2011@gmail.com> wrote:
>> Hi all,
>>
>> Here is the 4th version of supporting ALPS v5 protocol's device.
>
> Niels de Vos, CC'd, was kind enough to build a Fedora 19 kernel
> with this v4 patch added.  We've been testing it since yesterday.
>
> This patch has been successfully tested on:
>
>  * Dell Inspiron 17R SE / Inspiron 7720
>  * Dell Vostro 3360
>  * Fujitsu Lifebook AH532
>
> With the v4 patch, the touchpad:
>
> * is recognised as a touchpad
> * both KDE and Gnome can control it
> * Both hardware buttons (left/right) work
> * Both 1 & 2 finger scrolling works
>
> So, it seems good here. :)
>
> From my point of view, I would be happy to see this
> patch applied, and you're welcome to use:
>
>   Tested-by: Justin Clift <jclift@redhat.com>
>
> Side note - Many thanks to the Fedora Community members
> who tested this v4 patch on their hardware and reported
> back. :)
>
> * =C3=96zg=C3=BCr G=C3=BCndo=C4=9Fan
> * Stanislav Datskevich
> * Thane
> * Alexander Volovics
>
> Regards and best wishes,
>
> Justin Clift
>
> --
> Justin Clift <jclift@redhat.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
