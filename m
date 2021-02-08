Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA55C433DB
	for <linux-input@archiver.kernel.org>; Mon,  8 Feb 2021 16:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20B3A64E7B
	for <linux-input@archiver.kernel.org>; Mon,  8 Feb 2021 16:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbhBHQCB (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 8 Feb 2021 11:02:01 -0500
Received: from mga02.intel.com ([134.134.136.20]:28252 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232708AbhBHQBv (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 8 Feb 2021 11:01:51 -0500
IronPort-SDR: Y6mwRYz3aEgGmlXqC4jfG5IOzgONhOFXylht1gjMxOl9kMesE2cRfXRR4HoKKBln8rb+VDed9K
 C/0jY5umwpXQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="168856926"
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="168856926"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 08:00:02 -0800
IronPort-SDR: c7CLfHt80+yA9azdHJbQbf/tW/fO0BK07Yg65VDZyucPJhA4OLtCCZecbKygHGqrQD3ZgcMgHn
 PIo1yhQwaBIA==
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="509511001"
Received: from eshan-mobl.amr.corp.intel.com ([10.213.174.93])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 08:00:01 -0800
Message-ID: <37cf77123be66e14f517a59576cdaba9c5787d0d.camel@linux.intel.com>
Subject: Re: [PATCH] HID: intel-ish-hid: ipc: Add Tiger Lake H PCI device ID
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     You-Sheng Yang <vicamo.yang@canonical.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 08 Feb 2021 08:00:00 -0800
In-Reply-To: <20210204083315.122952-1-vicamo.yang@canonical.com>
References: <20210204083315.122952-1-vicamo.yang@canonical.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Thu, 2021-02-04 at 16:33 +0800, You-Sheng Yang wrote:
> Added Tiger Lake H PCI device ID to the supported device list.
> 
> Signed-off-by: You-Sheng Yang <vicamo.yang@canonical.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
>  drivers/hid/intel-ish-hid/ipc/hw-ish.h  | 1 +
>  drivers/hid/intel-ish-hid/ipc/pci-ish.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/hid/intel-ish-hid/ipc/hw-ish.h
> b/drivers/hid/intel-ish-hid/ipc/hw-ish.h
> index 1fb294ca463e..21b0e6123754 100644
> --- a/drivers/hid/intel-ish-hid/ipc/hw-ish.h
> +++ b/drivers/hid/intel-ish-hid/ipc/hw-ish.h
> @@ -27,6 +27,7 @@
>  #define CMP_H_DEVICE_ID		0x06FC
>  #define EHL_Ax_DEVICE_ID	0x4BB3
>  #define TGL_LP_DEVICE_ID	0xA0FC
> +#define TGL_H_DEVICE_ID		0x43FC
>  
>  #define	REVISION_ID_CHT_A0	0x6
>  #define	REVISION_ID_CHT_Ax_SI	0x0
> diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> index c6d48a8648b7..6dea657b7b15 100644
> --- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> +++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> @@ -37,6 +37,7 @@ static const struct pci_device_id ish_pci_tbl[] = {
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, CMP_H_DEVICE_ID)},
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, EHL_Ax_DEVICE_ID)},
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, TGL_LP_DEVICE_ID)},
> +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, TGL_H_DEVICE_ID)},
>  	{0, }
>  };
>  MODULE_DEVICE_TABLE(pci, ish_pci_tbl);

