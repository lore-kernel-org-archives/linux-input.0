From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v8 1/5] Input: elan_i2c: Export the device id whitelist
Date: Sat, 22 Jun 2019 23:20:00 -0700
Message-ID: <20190623062000.GB204275@dtor-ws>
References: <20190621144854.38568-1-jeffrey.l.hugo@gmail.com>
 <20190621145042.38637-1-jeffrey.l.hugo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190621145042.38637-1-jeffrey.l.hugo@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc: benjamin.tissoires@redhat.com, jikos@kernel.org, hdegoede@redhat.com, bjorn.andersson@linaro.org, agross@kernel.org, lee.jones@linaro.org, xnox@ubuntu.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Jun 21, 2019 at 07:50:42AM -0700, Jeffrey Hugo wrote:
> Elan_i2c and hid-quirks work in conjunction to decide which devices each
> driver will handle.  Elan_i2c has a whitelist of devices that should be
> consumed by hid-quirks so that there is one master list of devices to
> handoff between the drivers.  Put the ids in a header file so that
> hid-quirks can consume it instead of duplicating the list.
> 
> Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>

Benjamin, are you happy with this version?

Thanks.

-- 
Dmitry
