From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH v15 00/12] input: cyapa: instruction of cyapa patches
Date: Mon, 15 Dec 2014 06:10:23 -0800
Message-ID: <20141215141023.GB918@newt.localdomain>
References: <1418624603-19054-1-git-send-email-dudley.dulixin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:46367 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711AbaLOOK2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Dec 2014 09:10:28 -0500
Content-Disposition: inline
In-Reply-To: <1418624603-19054-1-git-send-email-dudley.dulixin@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dudley Du <dudley.dulixin@gmail.com>
Cc: dmitry.torokhov@gmail.com, rydberg@euromail.se, bleung@google.com, dso@cypress.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Dudley,

On Mon, Dec 15, 2014 at 02:23:11PM +0800, Dudley Du wrote:
> V15 patches have below updates, details of other updates see history list:
> 1) Fix all warning errors of sparse tool when running with "make C=1".
> 2) Change variable name "unique_str" to "product_id" for clearer meanings.
> 
> 
> This patch series is aimed to re-design the cyapa driver to support
> old gen3 trackpad devices and new gen5 trackpad devices in one
[...]

The patch set still tests fine on my Acer C720.

I went through all the patches and found lots of minor things to fix
as you would expect from this large amount of code.

I hope you don't get discouraged :-)

-- 
- Jeremiah Mahler
