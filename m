From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/4] Add acer wmi hotkey events support
Date: Sun, 31 Oct 2010 07:04:01 -0700
Message-ID: <201010310704.02268.dmitry.torokhov@gmail.com>
References: <1288456593-6868-1-git-send-email-jlee@novell.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1288456593-6868-1-git-send-email-jlee@novell.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org, carlos@strangeworlds.co.uk, corentin.chary@gmail.com, tiwai@novell.com, trenn@novell.com, mjg59@srcf.ucam.org, jbenc@suse.cz, "Lee, Chun-Yi" <jlee@novell.com>
List-Id: linux-input@vger.kernel.org

On Saturday, October 30, 2010 09:36:30 am Lee, Chun-Yi wrote:
> Add acer wmi hotkey event support. Install a wmi notify handler to
> transfer wmi event key to key code, then send out keycode through acer
> wmi input device to userland.
> 
> Signed-off-by: Lee, Chun-Yi <jlee@novell.com>

Looks good to me, thansk for making changes.

Acked-by: Dmitry Torokhov <dtor@mail.ru>

-- 
Dmitry
