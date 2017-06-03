From: Paul Donohue <linux-kernel@PaulSD.com>
Subject: Re: [REGRESSION] Touchpad failure after e7348396c6d5 ("Input: ALPS -
 fix V8+ protocol handling (73 03 28)")
Date: Sat, 3 Jun 2017 00:03:49 -0400
Message-ID: <20170603040349.GB16345@TopQuark.net>
References: <937d0082-5c51-e0b5-dcf9-efade5ecbde5@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from Lepton.TopQuark.net ([168.235.66.66]:58990 "EHLO
        Mail2.TopQuark.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750707AbdFCENr (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 3 Jun 2017 00:13:47 -0400
Content-Disposition: inline
In-Reply-To: <937d0082-5c51-e0b5-dcf9-efade5ecbde5@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Laura Abbott <labbott@redhat.com>
Cc: Masaki Ota <masaki.ota@jp.alps.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pali Rohar <pali.rohar@gmail.com>, Nick Fletcher <nick.m.fletcher@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, scott.s.lowe@gmail.com

This might be related to https://bugzilla.kernel.org/show_bug.cgi?id=195215

Could you have the user try this change? https://bugzilla.kernel.org/show_bug.cgi?id=195215#c12

On Fri, Jun 02, 2017 at 10:54:52AM -0700, Laura Abbott wrote:
> Hi,
> 
> Fedora got a bug report https://bugzilla.redhat.com/show_bug.cgi?id=1447327
> of a touchpad failure on a Dell Latitude E7370. Testing showed that the
> bad commit was
> 
> commit e7348396c6d51b57c95c6646c390cd078e038e19
> Author: Masaki Ota <masaki.ota@jp.alps.com>
> Date:   Fri Mar 17 14:10:57 2017 -0700
> 
>     Input: ALPS - fix V8+ protocol handling (73 03 28)
>     
>     Devices identified as E7="73 03 28" use slightly modified version of V8
>     protocol, with lower count per electrode, different offsets, and different
>     feature bits in OTP data.
>     
>     Fixes: aeaa881f9b17 ("Input: ALPS - set DualPoint flag for 74 03 28 devices")
>     Signed-off-by: Masaki Ota <masaki.ota@jp.alps.com>
>     Acked-by: Pali Rohar <pali.rohar@gmail.com>
>     Tested-by: Paul Donohue <linux-kernel@PaulSD.com>
>     Tested-by: Nick Fletcher <nick.m.fletcher@gmail.com>
>     Cc: stable@vger.kernel.org
>     Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> I suspect this particular model needs special handling as well?
> 
> Thanks,
> Laura
> 
