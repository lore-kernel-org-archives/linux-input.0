From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH] Input: axp20x-pek: use devm_add_action_or_reset
Date: Mon, 13 Jun 2016 11:53:15 +0800
Message-ID: <CAGb2v67dj9wLcvknmQ5v7gaqBpBLg8d=5gM6i7JcQBfaefVf2g@mail.gmail.com>
References: <1465740750-4881-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:40422 "EHLO
	smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933283AbcFMDxj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 12 Jun 2016 23:53:39 -0400
In-Reply-To: <1465740750-4881-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chen-Yu Tsai <wens@csie.org>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Sun, Jun 12, 2016 at 10:12 PM, Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
> If devm_add_action() fails we are explicitly calling
> axp20x_remove_sysfs_group() to free the resources allocated. Lets use
> the helper devm_add_action_or_reset() and return directly in case of
> error, as we know that the cleanup function has been already called by
> the helper if there was any error.
>
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

Acked-by: Chen-Yu Tsai <wens@csie.org>
