From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: xpad - use LED API when identifying wireless
 controllers
Date: Mon, 4 Jan 2016 16:50:17 -0800
Message-ID: <20160105005017.GA11801@dtor-ws>
References: <20151216224408.GA14261@dtor-ws>
 <20151219221709.5b5947ec@gromit>
 <20151220075504.GA35575@dtor-ws>
 <CA+b0ujeD_qV-MtPx7ktxMWw-UgxZq8d9BN6SgwA3F+RKaXz6ng@mail.gmail.com>
 <20151221200650.GB40090@dtor-ws>
 <CA+b0ujepYgvgC6tTeWBphQLEr+KXXzA48uGzxUvfO8yyXey6UA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34451 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753733AbcAEAuU (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Jan 2016 19:50:20 -0500
Content-Disposition: inline
In-Reply-To: <CA+b0ujepYgvgC6tTeWBphQLEr+KXXzA48uGzxUvfO8yyXey6UA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Rojtberg <rojtberg@gmail.com>
Cc: Clement Calmels <clement.calmels@free.fr>, linux-input@vger.kernel.org, "Pierre-Loup A. Griffais" <githubpublic@plagman.net>, linux-kernel@vger.kernel.org

On Thu, Dec 24, 2015 at 07:11:22PM +0100, Pavel Rojtberg wrote:
> 
> for me this one did the trick. The correct LED lights up after resume.
> 
> Integrated it here (master):
> https://github.com/paroj/xpad

Pavel, I refreshed my xpad branch on kernel.org folding the reset_resume
and anchor changes into your original suspend/resume patch. Could you
please try it out so that I can send it to mainline in the upcoming
merge window?

Thanks!

-- 
Dmitry
