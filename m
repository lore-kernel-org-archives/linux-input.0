From: Robert Munteanu <rombert@apache.org>
Subject: Re: [PATCH v3] Fix modifier keys for Redragon Asura Keyboard
Date: Thu, 22 Mar 2018 09:17:27 +0100
Message-ID: <1b0047c60fc5dc4be4bbe627ab830e65db1cfae5.camel@apache.org>
References: <20180321104331.22783-1-rombert@apache.org>
         <201803211751.04734.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201803211751.04734.linux@rainbow-software.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 2018-03-21 at 17:51 +0100, Ondrej Zary wrote:
> On Wednesday 21 March 2018 11:43:31 Robert Munteanu wrote:
> > +#define USB_VENDOR_ID_MICRODIA          0x0c45
> > +#define USB_DEVICE_ID_REDRAGON_ASURA    0x760b
> 
> Microdia is most probably an incorrect name. The 0c45 id probably
> belongs 
> to "Sonix Technology Co., Ltd."

Right, I was unsure about that. I'll remove the microdia references and
use sonix.

Robert
