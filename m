From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/2] Input: edt-ft5x06 - Add support for regulator
Date: Wed, 3 Jan 2018 13:48:23 -0600
Message-ID: <20180103194823.xmdvf6xmgcosksgy@rob-hp-laptop>
References: <20171228163336.28131-1-mylene.josserand@free-electrons.com>
 <20171228163336.28131-2-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:40931 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750819AbeACTsY (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 3 Jan 2018 14:48:24 -0500
Content-Disposition: inline
In-Reply-To: <20171228163336.28131-2-mylene.josserand@free-electrons.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@free-electrons.com>
Cc: dmitry.torokhov@gmail.com, mark.rutland@arm.com, linux@armlinux.org.uk, maxime.ripard@free-electrons.com, wens@csie.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, thomas.petazzoni@free-electrons.com, quentin.schulz@free-electrons.com

On Thu, Dec 28, 2017 at 05:33:35PM +0100, Mylène Josserand wrote:
> Add the support of regulator to use it as VCC source.
> 
> Signed-off-by: Mylène Josserand <mylene.josserand@free-electrons.com>
> ---
>  .../bindings/input/touchscreen/edt-ft5x06.txt      |  1 +
>  drivers/input/touchscreen/edt-ft5x06.c             | 33 ++++++++++++++++++++++
>  2 files changed, 34 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
