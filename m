From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/4] tty/vt/keyboard: Fix Caps Lock LED on major distributions
Date: Fri, 27 Jan 2017 09:29:00 -0800
Message-ID: <7BA8EE40-6F85-450A-AAAA-F39485D2F30E@gmail.com>
References: <20170127171318.2596-1-benjamin.tissoires@redhat.com> <20170127171318.2596-3-benjamin.tissoires@redhat.com> <20170127172514.GX9511@var.bordeaux.inria.fr>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35232 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934041AbdA0R3Q (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 27 Jan 2017 12:29:16 -0500
In-Reply-To: <20170127172514.GX9511@var.bordeaux.inria.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On January 27, 2017 9:25:14 AM PST, Samuel Thibault <samuel=2Ethibault@ens-=
lyon=2Eorg> wrote:
>Benjamin Tissoires, on Fri 27 Jan 2017 18:13:16 +0100, wrote:
>> +static bool caps_as_controlllock;
>
>Really, we don't want these=2E  Userspace could invent using another
>modifier, so it's really not the way forward=2E  Please have a look at
>what I suggested=2E

Completely agree=2E


Thanks=2E

--=20
Dmitry
