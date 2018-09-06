From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] HID: i2c-hid: Don't reset device upon system resume
Date: Thu, 6 Sep 2018 16:32:26 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1809061631250.15880@cbobk.fhfr.pm>
References: <20180906025518.30191-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180906025518.30191-1-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: benjamin.tissoires@redhat.com, hdegoede@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Aaron Ma <aaron.ma@canonical.com>, AceLan Kao <acelan.kao@canonical.com>
List-Id: linux-input@vger.kernel.org

On Thu, 6 Sep 2018, Kai-Heng Feng wrote:

> Raydium touchscreen triggers interrupt storm after system-wide suspend:
> [ 179.085033] i2c_hid i2c-CUST0000:00: i2c_hid_get_input: incomplete
> report (58/65535)
> 
> According to Raydium, Windows driver does not reset the device after
> system resume.
> 
> The HID over I2C spec does specify a reset should be used at
> intialization, but it doesn't specify if reset is required for system
> suspend.
> 
> Tested this patch on other i2c-hid touchpanels I have and those
> touchpanels do work after S3 without doing reset. If any regression
> happens to other touchpanel vendors, we can use quirk for Raydium
> devices.
> 
> There's still one device uses I2C_HID_QUIRK_RESEND_REPORT_DESCR so keep
> it there.
> 
> Cc: Aaron Ma <aaron.ma@canonical.com>
> Cc: AceLan Kao <acelan.kao@canonical.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Queued in for-4.19/fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs
