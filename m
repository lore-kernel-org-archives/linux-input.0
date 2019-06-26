From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: multitouch: Add pointstick support for ALPS
 Touchpad
Date: Wed, 26 Jun 2019 14:05:05 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1906261404540.27227@cbobk.fhfr.pm>
References: <20190614085655.8255-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190614085655.8255-1-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 14 Jun 2019, Kai-Heng Feng wrote:

> There's a new ALPS touchpad/pointstick combo device that requires
> MT_CLS_WIN_8_DUAL to make its pointsitck work as a mouse.
> 
> The device can be found on HP ZBook 17 G5.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Applied to for-5.2/fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs
