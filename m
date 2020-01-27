Return-Path: <SRS0=3IFa=3Q=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD938C33CB1
	for <linux-input@archiver.kernel.org>; Mon, 27 Jan 2020 16:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9545C21739
	for <linux-input@archiver.kernel.org>; Mon, 27 Jan 2020 16:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580141529;
	bh=DWzsry0pkIco+E21GTa76Al7WLLS7k30aRDDwLzkWJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Zon/ZrpO0VFH5LVuzGzMWQPYBWsGKcU4uVpmKiUn78gdDRwWYQ6WFIWodP7O2UDP0
	 xcOJNZLB1Uvs8oD9r/Q00GQzSVm1XF2feO4HokVNa1ClgEJs844sqiQB29dvOW6h7V
	 +Q5tfbpzS0MfoenTZKeX7lHDdP+BORBVfo/9ztP4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729705AbgA0QMI (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 27 Jan 2020 11:12:08 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44392 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729470AbgA0QMI (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 27 Jan 2020 11:12:08 -0500
Received: by mail-oi1-f195.google.com with SMTP id d62so7116631oia.11;
        Mon, 27 Jan 2020 08:12:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VpKkLhH8DyxXlZVd2fpbK7LMoBcW9GgF5sCbk+Nh5Tw=;
        b=qrJhbAavOYVr7oBcopcrh9fUek8yyKBx3tsuVgzBb302aCZXr7j7L4I6j/HgiPzmAt
         /nUSEsWU/Gg7Y5gYcpenT1Obic70y3BPtWcdy0Lrqs0yDdEWr6DX0xY9XkQ3cOveMz7c
         Uky7WOkHjCkQExDQFpl8RCofHmLqKVDTTgPBzNEeZ0jXGkfosTBKdPohfHSsTgP0+4ph
         BAMaPLxE03xS1dLbei653WqwbYPKQqF+803NNTRrPaScosM78izxIQrDVmNwH/0XNMjt
         Whq7C7bx0+cIj9sAQLURTTHrx3JYLfO6VhC+bCrKeNn/ykkOsFScwHT23mK6uc+ATIaO
         BnxA==
X-Gm-Message-State: APjAAAV5V/MVKvv/tL6tnjUj/k/wAoqxNcN39zm1F4IQe+GQM5ytCsyL
        4by9hJrCp+JzS+yBDXnoLEVNanU=
X-Google-Smtp-Source: APXvYqwKPGTpHUABqTXgmDO9PdXabZ0AnWLQMhsjTDIFpcq3UVsK60nYfsWEaUg0te4Y6GE1QUnZUA==
X-Received: by 2002:aca:3b45:: with SMTP id i66mr7723105oia.52.1580141527787;
        Mon, 27 Jan 2020 08:12:07 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o101sm5675764ota.69.2020.01.27.08.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 08:12:07 -0800 (PST)
Received: (nullmailer pid 18183 invoked by uid 1000);
        Mon, 27 Jan 2020 16:12:06 -0000
Date:   Mon, 27 Jan 2020 10:12:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Ikjoon Jang <ikjn@chromium.org>, devicetree@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Nicolas Boitchat <drinkcat@chromium.org>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: mfd: Convert ChromeOS EC bindings to
 json-schema
Message-ID: <20200127161206.GB30843@bogus>
References: <20200114021934.178057-1-ikjn@chromium.org>
 <20200121074727.35893-1-ikjn@chromium.org>
 <6739cc32-9beb-ac0a-f500-db2d70bb8e22@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6739cc32-9beb-ac0a-f500-db2d70bb8e22@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Mon, Jan 27, 2020 at 04:57:13PM +0100, Enric Balletbo i Serra wrote:
> Hi Ikjoon,
> 
> On 21/1/20 8:47, Ikjoon Jang wrote:
> > Convert the ChromeOS EC bindings to json-schema.
> > 
> > Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
> > ---
> > v3: node name changed in rpmsg example
> > v2: cleanup description, fix typos, remove LPC, add add RPMSG example
> > ---
> >  .../devicetree/bindings/mfd/cros-ec.txt       |  76 ------------
> >  .../devicetree/bindings/mfd/cros-ec.yaml      | 111 ++++++++++++++++++
> >  2 files changed, 111 insertions(+), 76 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/mfd/cros-ec.txt
> >  create mode 100644 Documentation/devicetree/bindings/mfd/cros-ec.yaml
> > 
> 
> Still in mfd directory, this is not a MFD driver, please move to chrome/cros-ec.yaml

Please don't. Looks to me like the chrome EC has multiple functions and 
is a device.

Bindings directories are often 1:1 with kernel driver directories, but 
not always.

Rob
