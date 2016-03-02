From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: How to use ACPI for touchscreen
Date: Wed, 2 Mar 2016 09:52:32 -0800
Message-ID: <20160302175232.GC4318@dtor-ws>
References: <CA+V1LzqohgdNChrBUO+VqUiPD-9gPGvSCiu0t3L7aUk5dRyD1w@mail.gmail.com>
 <56D568C7.20203@gmail.com>
 <CA+V1LzohZr1ryibyS+YQ75D8-txQaiYU5qo2CNWTKS2kwn53dg@mail.gmail.com>
 <CA+V1Lzp8pEtiwH-EWJiDCu=oFpXO9N2SEM5UbSqi5-mxgwsiTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34103 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752103AbcCBRwg (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Mar 2016 12:52:36 -0500
Received: by mail-pf0-f178.google.com with SMTP id 4so59325697pfd.1
        for <linux-input@vger.kernel.org>; Wed, 02 Mar 2016 09:52:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CA+V1Lzp8pEtiwH-EWJiDCu=oFpXO9N2SEM5UbSqi5-mxgwsiTg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: sergk sergk2mail <sergk.admin@gmail.com>
Cc: Gregor Riepl <onitake@gmail.com>, linux-input@vger.kernel.org

On Tue, Mar 01, 2016 at 04:55:02PM +0000, sergk sergk2mail wrote:
> In addition this touch is used like so:
> 
> dmesg | grep chipone:
> <6> : input: chipone-ts as /devices/virtual/input/input3
> cat /devices/virtual/input/input3/modalias gives
> 
> input:b000v0000p0000e0000-e0,1,3,k8B,9E,D9,ra2F,30,32,35,36,39,m1sfw
> - I guess the key is m1sfw which means loaded firmware.

Why do you think that mlsfw in modalias string has anything to do with
loading firmware? I must have misunderstood your statement...

Thanks.

-- 
Dmitry
