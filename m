Return-Path: <SRS0=o5X5=AG=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3016C433DF
	for <linux-input@archiver.kernel.org>; Thu, 25 Jun 2020 10:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4B7B20781
	for <linux-input@archiver.kernel.org>; Thu, 25 Jun 2020 10:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593082543;
	bh=TrUXVh5K34ExkyosZm6J1FzTLucnrfzr2MGexVTzx7A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eGLaBdXBHPvmSdoXwbph8TbgV4WG2+ySN34h1d/b2E/JuHpbQNDJAvgTV6PBZ3AbM
	 JjVVFLDlbLVicpbf140XNXhANwZXW5FX/xpI6eREdG9+YATdKuZd2+0I7rORlGQKhK
	 zGEzXb6ufVd0LzdMiybqOCdPqpGk5QeKHJ4RWR/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404063AbgFYKzm (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 25 Jun 2020 06:55:42 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46412 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404042AbgFYKzm (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 25 Jun 2020 06:55:42 -0400
Received: by mail-oi1-f195.google.com with SMTP id l63so4532914oih.13;
        Thu, 25 Jun 2020 03:55:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TrUXVh5K34ExkyosZm6J1FzTLucnrfzr2MGexVTzx7A=;
        b=EDEalBM1t/9VXmckPzbNjY25D6IoMcyNWBb+hrEoH8jC/Q+oJl8lSm80mjg2uQEnsh
         mJ0iQjPQfGG+unfCTOArQ+VmLCvtKMXRSwP4fJco608qCO5CPZd1VaCwGmK9BOw63mmP
         NrtqP3qMjG+0wwsRXJpJE+pKRF9dObo0D8Gej1TYA/P31WadIrw8w7E8QVOvCX+Bk27q
         8gyI1sPv2Bo5ToZUbNOkxRkgk8tC2jKRjjb6zrH/V3RftrlxwGMt+glqGLRufzEryXNF
         QF5SqyR6mUhfF8hsVSWXpvCnw6X61kUcMaVmwx01R68uF8LvwK5En2j1fNDcr9DMZC03
         m6oA==
X-Gm-Message-State: AOAM531di9ZZWLCC6i8yU52Hj9OgbdYK0jECXSnsfdZzZQ6a9wboRJ6c
        2OUybgKXOH15f68+aCJOTa3Q+K5CaMcguS2Hn7c=
X-Google-Smtp-Source: ABdhPJxEHcU+htFP7B4i5hFRJBFdP4Ml1jBQ9xnktdScLVwnwA+huwt1DnfbyHYvIexy3b5Mqz0mUcFvn4VuBdP0DQA=
X-Received: by 2002:a54:4585:: with SMTP id z5mr1709742oib.110.1593082540828;
 Thu, 25 Jun 2020 03:55:40 -0700 (PDT)
MIME-Version: 1.0
References: <2336e15d-ff4b-bbb6-c701-dbf3aa110fcd@redhat.com>
 <20200608112211.12125-1-andrzej.p@collabora.com> <20200608112211.12125-4-andrzej.p@collabora.com>
 <CAJZ5v0j7e9TzDtEiDXmj3fLAQ7CvFHoe7Q3aYKKas3PEXrsUuw@mail.gmail.com> <20200625052318.GE248110@dtor-ws>
In-Reply-To: <20200625052318.GE248110@dtor-ws>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 25 Jun 2020 12:55:29 +0200
Message-ID: <CAJZ5v0hgQt-amMn8xiF_0kyVZ-9pQxgm5H-VcFpinVQGKnYhwQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] ACPI: button: Access input device's users under
 appropriate mutex
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>,
        linux-input@vger.kernel.org,
        linux-tegra <linux-tegra@vger.kernel.org>,
        patches@opensource.cirrus.com,
        ibm-acpi-devel@lists.sourceforge.net,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Barry Song <baohua@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Nick Dyer <nick@shmanahar.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ferruh Yigit <fery@cypress.com>,
        Sangwon Jee <jeesw@melfas.com>,
        Peter Hutterer <peter.hutterer@redhat.com>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Collabora Kernel ML <kernel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Thu, Jun 25, 2020 at 7:23 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Wed, Jun 24, 2020 at 05:00:09PM +0200, Rafael J. Wysocki wrote:
> > On Mon, Jun 8, 2020 at 1:22 PM Andrzej Pietrasiewicz
> > <andrzej.p@collabora.com> wrote:
> > >
> > > Inspecting input device's 'users' member should be done under device's
> > > mutex, so add appropriate invocations.
> > >
> > > Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
> >
> > This looks like a fix that might be applied independently of the other
> > patches in the series.
> >
> > Do you want me to pick it up?
>
> If you pick it we'll have to have a dance with this series. Can I apply
> instead?

Yes, please.

Also feel free to add

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to it.

> I do not think this change has any practical effect as nobody
> attaches/detached input handlers or opening/closing input devices when
> system goes through device resume phase.

Indeed.

Thanks!
