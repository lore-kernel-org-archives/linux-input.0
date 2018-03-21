From: Ondrej Zary <linux@rainbow-software.org>
Subject: Re: [PATCH v3] Fix modifier keys for Redragon Asura Keyboard
Date: Wed, 21 Mar 2018 17:51:04 +0100
Message-ID: <201803211751.04734.linux@rainbow-software.org>
References: <20180321104331.22783-1-rombert@apache.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180321104331.22783-1-rombert@apache.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Munteanu <rombert@apache.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wednesday 21 March 2018 11:43:31 Robert Munteanu wrote:
> +#define USB_VENDOR_ID_MICRODIA          0x0c45
> +#define USB_DEVICE_ID_REDRAGON_ASURA    0x760b

Microdia is most probably an incorrect name. The 0c45 id probably belongs 
to "Sonix Technology Co., Ltd."

-- 
Ondrej Zary
