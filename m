From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v2] input: Extend matrix-keypad device tree binding
Date: Fri, 11 Jan 2013 10:09:19 -0700
Message-ID: <50F0473F.404@wwwdotorg.org>
References: <1357868492-16023-1-git-send-email-sjg@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1357868492-16023-1-git-send-email-sjg@chromium.org>
Sender: linux-doc-owner@vger.kernel.org
To: Simon Glass <sjg@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Roland Stigge <stigge@antcom.de>, Vincent Palatin <vpalatin@chromium.org>, linux-doc@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Wolfram Sang <w.sang@pengutronix.de>, Felipe Balbi <balbi@ti.com>, Luigi Semenzato <semenzato@chromium.org>, Rob Herring <rob.herring@calxeda.com>, linux-input@vger.kernel.org, Stephen Warren <swarren@nvidia.com>, Sourav Poddar <sourav.poddar@ti.com>, Alban Bedel <alban.bedel@avionic-design.de>, devicetree-discuss@lists.ozlabs.org, Laxman Dewangan <ldewangan@nvidia.com>
List-Id: linux-input@vger.kernel.org

On 01/10/2013 06:41 PM, Simon Glass wrote:
> Some matrix keypad drivers can support different numbers of rows and
> columns. Add a generic binding for these.
> 
> Implementation note:
> 
> In order to implement this binding in the kernel, we will need to modify
> matrix_keypad_() to look up the number of rows and cols in
> the keymap. Perhaps this could be done by passing 0 for these parameters?
> Many of the parameters can already be set to NULL. Ick.

Reviewed-by: Stephen Warren <swarren@nvidia.com>

Note that the Tegra bindings are based on matrix-keypad.txt, and
recently added the following properties:

> - nvidia,kbc-row-pins: The KBC pins which are configured as row. This is an
>   array of pin numbers which is used as rows.
> - nvidia,kbc-col-pins: The KBC pins which are configured as column. This is an
>   array of pin numbers which is used as column.

Those both define the number of rows/columns (indirectly via the
property lengths) *and* define which pins are used for the rows/columns.
How will this influence/interact-with any changes you're planning to the
core matrix keymap parsing code; would Tegra require your "new"
keypad,num-rows/keypad,num-columns properties even though the
information is redundant, or will the Tegra driver have some way of
passing this information to the core?
