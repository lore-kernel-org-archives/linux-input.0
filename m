From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] hidraw: Fix crash on HIDIOCGFEATURE with a destroyed
 device
Date: Mon, 9 Apr 2018 09:30:48 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1804090930390.28129@cbobk.fhfr.pm>
References: <20180405230936.4572-1-rodrigorivascosta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180405230936.4572-1-rodrigorivascosta@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 6 Apr 2018, Rodrigo Rivas Costa wrote:

> Doing `ioctl(HIDIOCGFEATURE)` in a tight loop on a hidraw device
> and then disconnecting the device, or unloading the driver, can
> cause a NULL pointer dereference.
> 
> When a hidraw device is destroyed it sets 0 to `dev->exist`.
> Most functions check 'dev->exist' before doing its work, but
> `hidraw_get_report()` was missing that check.
> 
> Signed-off-by: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>

Applied, thank you.

-- 
Jiri Kosina
SUSE Labs
