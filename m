From: Yu Chen <yu.c.chen@intel.com>
Subject: Re: [PATCH v3 1/2] platform/x86: surfacepro3_button: Fix device check
Date: Fri, 26 Jul 2019 09:48:52 +0800
Message-ID: <20190726014851.GA15416@chenyu-office.sh.intel.com>
References: <20190720150511.95076-1-luzmaximilian@gmail.com>
 <20190720150511.95076-2-luzmaximilian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190720150511.95076-2-luzmaximilian@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Maximilian Luz <luzmaximilian@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

On Sat, Jul 20, 2019 at 05:05:10PM +0200, Maximilian Luz wrote:
> Do not use the surfacepro3_button driver on newer Microsoft Surface
> models, only use it on the Surface Pro 3 and 4. Newer models (5th, 6th
> and possibly future generations) use the same device as the Surface Pro
> 4 to represent their volume and power buttons (MSHW0040), but their
> actual implementation is significantly different. This patch ensures
> that the surfacepro3_button driver is only used on the Pro 3 and 4
> models, allowing a different driver to bind on other models.
> 
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> ---
Acked-by: Chen Yu <yu.c.chen@intel.com>

Thanks,
Chenyu
