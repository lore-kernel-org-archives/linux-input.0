From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 1/1] hid: hid-sensor-custom: simplify getting
 .driver_data
Date: Wed, 27 Mar 2019 14:06:40 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1903271406260.19912@cbobk.fhfr.pm>
References: <20190319163638.31003-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190319163638.31003-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 19 Mar 2019, Wolfram Sang wrote:

> We should get 'driver_data' from 'struct device' directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-5.2/sensor, thanks.

-- 
Jiri Kosina
SUSE Labs
