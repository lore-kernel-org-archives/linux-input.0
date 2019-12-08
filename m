Return-Path: <SRS0=VovD=Z6=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01B4C2D0BE
	for <linux-input@archiver.kernel.org>; Sun,  8 Dec 2019 02:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D07D21835
	for <linux-input@archiver.kernel.org>; Sun,  8 Dec 2019 02:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575772691;
	bh=8mgPzHZzKvYJ806I0wHDu1FGsN/YycYQJkEG3Ub5PCc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZjI/WechOuIoiPSguokXXsnclzHnfv6+2/vtm9PN3WBbO87weAVww6VcfodHR4HI0
	 AcRoJvmT9Ckfu3Yl0N9FSmFOr2G3oIZloofYO4KrW2ScWlGEPKRWTTKgIh/Ayeoc21
	 mHFCHTxQInjaVQx0PBevdN5d/l54M5G8qfFWO4fY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfLHCgM (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sat, 7 Dec 2019 21:36:12 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40885 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfLHCgL (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 7 Dec 2019 21:36:11 -0500
Received: by mail-lj1-f194.google.com with SMTP id s22so11748535ljs.7
        for <linux-input@vger.kernel.org>; Sat, 07 Dec 2019 18:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a4jfnZBW3KpYqP1Bv2BekVx6xqeSOyyCAahQiCKEzmI=;
        b=gpm7ue+/WAaHJLspUVE0QHZjp9pYnUFrx5hP6CyG9vZV3BGNG87eo+wyaHng0ZzJyV
         jwWpyon4dyyOqUTtTihxUTSW+iJMhK07xO1DeUKTKVkKWMa83YkTFgGKGBaOvMPc64jq
         rHKtDEzG8fl2ltu7L9C5jlkLv2jd0uaLNnonY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a4jfnZBW3KpYqP1Bv2BekVx6xqeSOyyCAahQiCKEzmI=;
        b=UU91zuExvfqIXDqr4woum5eYB30dKsWy0jY73dwES1y2rOwF76Wq5c3s4F/g1dVVF3
         8NgnhMT+blYgWrUJlm4QeOhV6hYXzaHf5ISUN8IVFac3hZpau16FFH/RWmiT2iWXO+kb
         wLeMWTe9In3HYPLDvgCfNDtiaucq8lhjnVJ4ObaYDvtPCPgHum7KjrpWDEy3CL3nC4+2
         YYW9mkRwugZ3mdsvKSinn9pdlnTq7BjFGigZD85GQyKtWYKxe5Gns3rriv4ciNrGIEk9
         4d6rWLf13PzYQrZDqzGGYoksirZf4snn+HUQXzTopNeIluW5N59lOOZ+WifNxD2xYNmw
         nzbA==
X-Gm-Message-State: APjAAAVkPAFNeNYtVsfZcd36tCujLa+eI0Y8/Tsa2M6EAqyVoNNJg9G/
        Gj6znjAHKDokcexqz6lPATyh/7eCWfA=
X-Google-Smtp-Source: APXvYqxzp1kWwgteRIDi5iPeUendQNzfG7NAwG4wIjbLN69MRCbS+1IS27fZGIGQgYxP6S+Ii72bnA==
X-Received: by 2002:a2e:93d5:: with SMTP id p21mr13353109ljh.50.1575772569462;
        Sat, 07 Dec 2019 18:36:09 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id m15sm9102455ljg.4.2019.12.07.18.36.08
        for <linux-input@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2019 18:36:08 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id c9so7586847lfi.6
        for <linux-input@vger.kernel.org>; Sat, 07 Dec 2019 18:36:08 -0800 (PST)
X-Received: by 2002:ac2:555c:: with SMTP id l28mr11709241lfk.52.1575772567987;
 Sat, 07 Dec 2019 18:36:07 -0800 (PST)
MIME-Version: 1.0
References: <20191207202733.GA153817@dtor-ws>
In-Reply-To: <20191207202733.GA153817@dtor-ws>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 7 Dec 2019 18:35:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiNz9CtHCobs+WNKeCcgd23adbRtPzoBk7WwEw_Z=i5wA@mail.gmail.com>
Message-ID: <CAHk-=wiNz9CtHCobs+WNKeCcgd23adbRtPzoBk7WwEw_Z=i5wA@mail.gmail.com>
Subject: Re: [git pull] Input updates for v5.5-rc0
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Sat, Dec 7, 2019 at 12:27 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> - one can now poll uinput device for writing (which is always allowed)

Well, except the code says "if there is data to be read, then it's
_only_ readable, and you can't write to it".

Is that what you wanted/meant?

                Linus
