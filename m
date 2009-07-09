From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] pcspkr: switch driver to dev_pm_ops
Date: Wed, 8 Jul 2009 23:02:56 -0700
Message-ID: <20090709060256.GC14516@dtor-d630.eng.vmware.com>
References: <200907081418.37229.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f175.google.com ([209.85.222.175]:60501 "EHLO
	mail-pz0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677AbZGIGDC (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jul 2009 02:03:02 -0400
Content-Disposition: inline
In-Reply-To: <200907081418.37229.elendil@planet.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Wed, Jul 08, 2009 at 02:18:36PM +0200, Frans Pop wrote:
> Gets rid of the following warning:
> Platform driver 'pcspkr' needs updating - please use dev_pm_ops
> 
> Signed-off-by: Frans Pop <elendil@planet.nl>
> Cc: Rafael J. Wysocki <rjw@sisk.pl>

Applied, thanks Frans.

-- 
Dmitry
