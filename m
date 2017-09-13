From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: i2c-hid: allocate hid buffers for real worst case
Date: Wed, 13 Sep 2017 09:18:15 -0700 (PDT)
Message-ID: <nycvar.YFH.7.76.1709130917510.4703@jbgna.fhfr.qr>
References: <20170908175527.GA19720@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170908175527.GA19720@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Guenter Roeck <groeck@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 8 Sep 2017, Dmitry Torokhov wrote:

> From: Adrian Salido <salidoa@google.com>
> 
> The buffer allocation is not currently accounting for an extra byte for
> the report id. This can cause an out of bounds access in function
> i2c_hid_set_or_send_report() with reportID > 15.
> 
> Signed-off-by: Guenter Roeck <groeck@chromium.org>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

I've added the missing tags and applied to for-4.14/upstream-fixes

-- 
Jiri Kosina
SUSE Labs
