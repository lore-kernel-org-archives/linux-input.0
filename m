From: Florian Echtler <floe@butterbrot.org>
Subject: Re: [PATCH] Added support for the Cando dual touch panel
Date: Thu, 15 Apr 2010 12:28:55 -0400
Message-ID: <1271348935.4941.68.camel@flunder>
References: <20100414190341.25BD8951EF@smtp.lii-enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from static.88-198-47-201.clients.your-server.de ([88.198.47.201]:38322
	"EHLO butterbrot.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752540Ab0DOQ26 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Apr 2010 12:28:58 -0400
In-Reply-To: <20100414190341.25BD8951EF@smtp.lii-enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephane Chatty <chatty@lii-enac.fr>
Cc: dmitry.torokhov@gmail.com, jkosina@suse.cz, linux-input@vger.kernel.org, priya.vijayan@intel.com, chatty@enac.fr

Hello Stephane,

I see you didn't use HID_CONNECT_HIDINPUT_FORCE after all.
Was that intentional?

> +	ret = hid_parse(hdev);
> +	if (!ret)
> +		ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);

Thanks, Yours, Florian

