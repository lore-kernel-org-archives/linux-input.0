From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 1/1] hid: i2c-hid: move header file out of I2C realm
Date: Mon, 22 May 2017 14:01:03 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1705221400520.26873@cbobk.fhfr.pm>
References: <20170521203033.6146-1-wsa@the-dreams.de> <20170521203033.6146-2-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <20170521203033.6146-2-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, 21 May 2017, Wolfram Sang wrote:

> include/linux/i2c is not for client devices. Move the header file to a
> more appropriate location.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Applied to for-4.13/upstream. Thanks,

-- 
Jiri Kosina
SUSE Labs
