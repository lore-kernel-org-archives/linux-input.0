From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v5 2/3] HID: quirks: Refactor ELAN 400 and 401 handling
Date: Wed, 12 Jun 2019 16:45:11 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1906121644160.27227@cbobk.fhfr.pm>
References: <20190606161055.47089-1-jeffrey.l.hugo@gmail.com> <20190606161322.47192-1-jeffrey.l.hugo@gmail.com> <20190612003507.GG143729@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190612003507.GG143729@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>, benjamin.tissoires@redhat.com, bjorn.andersson@linaro.org, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, agross@kernel.org, david.brown@linaro.org, hdegoede@redhat.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 11 Jun 2019, Dmitry Torokhov wrote:

> > +static const char *hid_elan_i2c_ignore[] = {
> 
> If this is a copy of elan whitelist, then, if we do not want to bother
> with sharing it in object form (as a elan-i2c-ids module), can we at
> least move it into include/linux/input/elan-i2c-ids.h and consume from
> hid-quirks.c?

Let's just not duplicate it in both objects. Why not properly export it 
from hid_quirks?

Thanks,

-- 
Jiri Kosina
SUSE Labs
