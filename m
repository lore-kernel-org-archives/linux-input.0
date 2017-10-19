From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: hid-logitech: remove redundant assignment to pointer
 value
Date: Thu, 19 Oct 2017 13:53:22 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1710191353080.9294@jbgna.fhfr.qr>
References: <20171017143151.23056-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171017143151.23056-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 17 Oct 2017, Colin King wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> The pointer value is being assigned a value and this is never read,
> and later on it is being assigned a new value.  This the first
> assignment is redundant and can be removed and hence also the variables
> report and report_list.  Cleans up the clang warning: Value stored to
> 'value' during its initialization is never read
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to for-4.15/logitech. Thanks,

-- 
Jiri Kosina
SUSE Labs
