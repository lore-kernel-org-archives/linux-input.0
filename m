From: Patrik Fimml <patrikf@chromium.org>
Subject: Re: [PATCH v2 0/14] input: cyapa: re-architecture driver to support
 multi-trackpads in one driver
Date: Mon, 30 Jun 2014 12:59:35 -0700
Message-ID: <20140630195935.GA18256@google.com>
References: <CAEn7tidaRxbLwQti8joDgq48K2YCAVE3uG-q6ZR=jEWAgm2tPg@mail.gmail.com>
 <77BC725C9062764F874D79F51E1F1A8F4C902B3B@S04-MBX01-01.s04.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:63934 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753348AbaF3T7i (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Jun 2014 15:59:38 -0400
Received: by mail-pa0-f41.google.com with SMTP id fb1so9260761pad.0
        for <linux-input@vger.kernel.org>; Mon, 30 Jun 2014 12:59:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <77BC725C9062764F874D79F51E1F1A8F4C902B3B@S04-MBX01-01.s04.local>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dudley Du <dudl@cypress.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alan Stern <stern@rowland.harvard.edu>, Benson Leung <bleung@google.com>, Lily Rui <lily@cypress.com>, Daniel Kurtz <djkurtz@google.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Dudley,

On Mon, Jun 30, 2014 at 05:43:06AM +0000, Dudley Du wrote:
> Attached are the patches files, I sent it firstly.

Thanks for the response, I was able to apply the patches now.

The attached files lack headers and commit messages though, so I don't have
fine-grained history in my git tree for convenient later review. The file names
suggest to me that you might just have copy-and-pasted the patches from
somewhere.

It would be great if you could attach them again in the format produced by "git
format-patch", with no further modifications done by hand. (If you feel the
need to do modifications, you should modify the actual commits e.g. with "git
rebase -i" before using format-patch.) Others can then simply import your
changes - including commit messages - into their tree with "git am".

Thanks,
Patrik
