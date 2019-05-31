From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v3] HID: fix A4Tech horizontal scrolling
Date: Sat, 1 Jun 2019 00:28:53 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1906010028440.1962@cbobk.fhfr.pm>
References: <20190507050029.GA5197@jelly> <20190512203313.18756-1-spaz16@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190512203313.18756-1-spaz16@wp.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-2?Q?B=B3a=BFej_Szczygie=B3?= <spaz16@wp.pl>
Cc: igorkuo@gmail.com, peter.hutterer@who-t.net, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, 12 May 2019, Błażej Szczygieł wrote:

> Since recent high resolution scrolling changes the A4Tech driver must
> check for the "REL_WHEEL_HI_RES" usage code.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=203369
> Fixes: 2dc702c991e3774af9d7ce410eef410ca9e2357e ("HID: input: use the
> Resolution Multiplier for high-resolution scrolling")
> 
> Signed-off-by: Błażej Szczygieł <spaz16@wp.pl>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
