From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v6] Input: sysrq - DT binding for key sequence
Date: Sat, 3 Aug 2013 17:30:38 -0700
Message-ID: <20130804003038.GA7769@core.coreip.homeip.net>
References: <1375115638-21236-1-git-send-email-mathieu.poirier@linaro.org>
 <CACxGe6u9-sEzxdDzc8T2HFNMqh-LHbTepUHqDF_tLLjxSxSG4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:62354 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004Ab3HDAam (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 3 Aug 2013 20:30:42 -0400
Content-Disposition: inline
In-Reply-To: <CACxGe6u9-sEzxdDzc8T2HFNMqh-LHbTepUHqDF_tLLjxSxSG4Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Grant Likely <grant.likely@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robherring2@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, kernel-team@android.com

On Mon, Jul 29, 2013 at 10:09:54PM -0600, Grant Likely wrote:
> On Mon, Jul 29, 2013 at 10:33 AM,  <mathieu.poirier@linaro.org> wrote:
> > From: "Mathieu J. Poirier" <mathieu.poirier@linaro.org>
> >
> > Adding a simple device tree binding for the specification of key sequences.
> > Definition of the keys found in the sequence are located in
> > 'include/uapi/linux/input.h'.
> >
> > For the sysrq driver, holding the sequence of keys down for a specific amount of time
> > will reset the system.
> >
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
> Acked-by: Grant Likely <grant.likely@linaro.org>

Applied, thank you.

-- 
Dmitry
