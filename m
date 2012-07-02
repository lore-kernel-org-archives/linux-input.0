From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 2/2] Input: synaptics - add sysfs access to firmware ID &
 board ID
Date: Mon, 2 Jul 2012 09:36:33 +0200
Message-ID: <20120702073632.GB624@polaris.bitmath.org>
References: <1340859117-19654-1-git-send-email-djkurtz@chromium.org>
 <1340859117-19654-2-git-send-email-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b22.telenor.se ([195.54.99.213]:54423 "EHLO
	smtprelay-b22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932326Ab2GBHgW (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Jul 2012 03:36:22 -0400
Content-Disposition: inline
In-Reply-To: <1340859117-19654-2-git-send-email-djkurtz@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Alessandro Rubini <rubini@ipvvis.unipv.it>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Olof Johansson <olof@lixom.net>, Benson Leung <bleung@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jun 28, 2012 at 12:51:57PM +0800, Daniel Kurtz wrote:
> Allow userspace to query firmware ID and board ID, which are read and
> cached during device initialization.
> 
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> ---
>  drivers/input/mouse/synaptics.c |   41 +++++++++++++++++++++++++++++++++++++++
>  1 files changed, 41 insertions(+), 0 deletions(-)

Since there is no common way to extract the firmware id for input
devices, any userland code that wants to use these sysfs nodes needs
to know about the details of this specific driver. I am not sure the
usefulness of it all outweighs the complication it incurs. It would be
good to hear about the rationale for inclusion here.

Thanks,
Henrik
