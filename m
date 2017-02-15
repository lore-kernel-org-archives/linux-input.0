From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Fix for out of range for THT 2p arcade controller
Date: Wed, 15 Feb 2017 09:14:58 -0800
Message-ID: <CAKdAkRQPvtnZ_T61S8Szw_bKjUyCEF_dGPosJK4Vd4XPuLVfBQ@mail.gmail.com>
References: <CAJRvzP98MyLzm5OZgUm6zVWFFVtwr2fe42FxY8UMeAQwyARmcw@mail.gmail.com>
 <alpine.LSU.2.20.1702100304250.24579@cbobk.fhfr.pm> <CAJRvzP-B1A2eUXT+5w0E7fA1kAV7HWxsX_Uu=-axBmxTsUaZTg@mail.gmail.com>
 <alpine.LSU.2.20.1702141557230.24579@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f68.google.com ([209.85.213.68]:36771 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751745AbdBORPE (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 15 Feb 2017 12:15:04 -0500
Received: by mail-vk0-f68.google.com with SMTP id n125so13191319vke.3
        for <linux-input@vger.kernel.org>; Wed, 15 Feb 2017 09:15:04 -0800 (PST)
In-Reply-To: <alpine.LSU.2.20.1702141557230.24579@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Stein <peter@stuntstein.dk>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>

On Tue, Feb 14, 2017 at 6:57 AM, Jiri Kosina <jikos@kernel.org> wrote:
> On Fri, 10 Feb 2017, Peter Stein wrote:
>
>> I am so sorry that I screw it up. I forgot to activate plain text in
>> gmail. I hope this time it is received in proper format.
>
> Hi Peter,
>
> unfortunately it's still line-wrapped.
>

Peter,

Pasting patch into gmail interface always corrupts it, even if you
select "plain text mode". The best way to send a patch is using "git
send-email". Stick the following in .git/config (or your ~/.gitconfig)

[sendemail]
        smtpserver = smtp.gmail.com
        smtpserverport = 587
        smtpencryption = tls
        smtpUser = <gmail user name>

Then you can do:

git send-email --annotate --smtpPass=<your gmail password> --to="list,
of, recepients" --cc="list, of, recepients" HEAD^..HEAD

to send the latest commit/patch. "--annotate" will allow you to edit
message(s) before sending.

Thanks.

-- 
Dmitry
