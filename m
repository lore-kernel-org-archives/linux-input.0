From: Thomas Chou <thomas@wytron.com.tw>
Subject: Re: [PATCH v2] input: touchscreen: add OF match table for ads7846
Date: Tue, 14 Jun 2011 14:15:12 +0800
Message-ID: <4DF6FC70.2050707@wytron.com.tw>
References: <1308015955-8286-1-git-send-email-Baohua.Song@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.wytron.com.tw ([211.75.82.101]:57260 "EHLO
	www.wytron.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342Ab1FNGWO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Jun 2011 02:22:14 -0400
In-Reply-To: <1308015955-8286-1-git-send-email-Baohua.Song@csr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Barry Song <Baohua.Song@csr.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, DL-SHA-APBULinux@csr.com, junyi.zhang@csr.com, Grant Likely <grant.likely@secretlab.ca>

On 06/14/2011 09:45 AM, Barry Song wrote:
> The current ads7846 has no OF match table. The method used is by applying a heuristic (of_modalias_node) which tries to name the device in a way that will match an existing device driver.
> This patch adds explicit OF match table for ads7846, then the normal device tree match behaviour will always work.
> It has been tested on PRIMA2 EVB board of CSR with a SPI's child node like the below:
> ts@0 {
>          compatible = "ti,ads7845";
>          reg =<0x0>;
>          spi-max-frequency =<31250>;
>          interrupts =<90>;
> };
>

Hi Barry,

Thank you very much for your help. Could we add an option for gpio 
pendown, like this?

- gpios : should specify GPIO used for pendown.

If interrupt node is not present in this node, gpio_to_irq of the pen
down GPIO will be used.

Best regards,
Thomas
