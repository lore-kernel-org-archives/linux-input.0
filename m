From: Aaron Ma <aaron.ma@canonical.com>
Subject: Re: [PATCH 1/2] Input: synaptics-rmi4 - clear irqs before set irqs
Date: Sat, 9 Mar 2019 16:37:33 +0800
Message-ID: <a0f21198-5715-8858-8368-51e43092181e@canonical.com>
References: <20190220164200.31044-1-aaron.ma@canonical.com>
 <17cd420ea32a9787c56ba25e36e7661541c2f65f.camel@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <17cd420ea32a9787c56ba25e36e7661541c2f65f.camel@synaptics.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christopher Heiny <Cheiny@synaptics.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

Hi,

On 3/9/19 7:13 AM, Christopher Heiny wrote:
> I'm not sure this is a safe action, due to a race condition with the
> actual IRQ handler (rmi_process_interrupt_requests from rmi_driver.c). 
> Remember that reading the IRQ status register clears all the IRQ bits. 
> So you're faced with this possible scenario:
>     - ATTN asserted, indicating new data in IRQ status register
>     - rmi_driver_set_irq_bits called
>     - rmi_driver_set_irq_bits reads IRQ status, clearing bits
>     - rmi_process_interrupt_requests called
>     - rmi_process_interrupt_request reads IRQ status, sees no
>       bits set, nested IRQs are not handled
> This could lead to loss of data or inconsistent system state
> information.  For example, a button up or down event may be lost, with
> consequent weird behavior by the user interface.

rmi_driver_set_irq_bits is only called to config and enable specific
functions of RMI.
Reading IRQ status before set irqs is supposed to clear spam data/irq
status.
spam data make probe/detect touchpad/trackpoint fail.

rmi_smb_resume -> rmi_driver_reset_handler -> fn-config ->
clear_irq_bits -> set_irq_bits -> enable_irq -> irq_handler  ->
rmi_process_interrupt_requests

set_irq_bits will not be in interrupt context, it enables IRQ bits of RMI.

Regards,
Aaron
