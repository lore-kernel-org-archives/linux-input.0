From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] RFC: input: Extend matrix-keypad device tree binding
Date: Thu, 20 Dec 2012 14:03:22 -0700
Message-ID: <50D37D1A.1030404@wwwdotorg.org>
References: <1356035039-21653-1-git-send-email-sjg@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1356035039-21653-1-git-send-email-sjg@chromium.org>
Sender: linux-doc-owner@vger.kernel.org
To: Simon Glass <sjg@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Roland Stigge <stigge@antcom.de>, Vincent Palatin <vpalatin@chromium.org>, linux-doc@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Wolfram Sang <w.sang@pengutronix.de>, Felipe Balbi <balbi@ti.com>, Luigi Semenzato <semenzato@chromium.org>, Rob Herring <rob.herring@calxeda.com>, linux-input@vger.kernel.org, Stephen Warren <swarren@nvidia.com>, Sourav Poddar <sourav.poddar@ti.com>, devicetree-discuss@lists.ozlabs.org
List-Id: linux-input@vger.kernel.org

On 12/20/2012 01:23 PM, Simon Glass wrote:
> Some matrix keypad drivers can support different numbers of rows and
> columns. Add a generic binding for these.

Oh, I thought num-rows/columns were already there!

Anyway, looks fine to me, so,
Reviewed-by: Stephen Warren <swarren@nvidia.com>

