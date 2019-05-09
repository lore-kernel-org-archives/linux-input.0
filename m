From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: i2c-hid: add iBall Aer3 to descriptor override
Date: Thu, 9 May 2019 21:29:31 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1905092129210.17054@cbobk.fhfr.pm>
References: <20190422065704.27234-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190422065704.27234-1-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 22 Apr 2019, Kai-Heng Feng wrote:

> This device uses the SIPODEV SP1064 touchpad, which does not
> supply descriptors, so it has to be added to the override
> list.
> 
> BugLink: https://bugs.launchpad.net/bugs/1825718
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Applied to for-5.2/fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs
