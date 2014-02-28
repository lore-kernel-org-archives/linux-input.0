From: "Wang, Yalin" <Yalin.Wang@sonymobile.com>
Subject: change kmalloc into vmalloc for large memory allocations
Date: Fri, 28 Feb 2014 16:15:23 +0800
Message-ID: <35FD53F367049845BC99AC72306C23D102844605F38C@CNBJMBX05.corpusers.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'linux-arm-msm@vger.kernel.org'" <linux-arm-msm@vger.kernel.org>, "'linux-arm-kernel@lists.infradead.org'" <linux-arm-kernel@lists.infradead.org>, "'linux-input@vger.kernel.org'" <linux-input@vger.kernel.org>, "'balbi@ti.com'" <balbi@ti.com>, "'gregkh@linuxfoundation.org'" <gregkh@linuxfoundation.org>, "'lrg@ti.com'" <lrg@ti.com>, "'broonie@opensource.wolfsonmicro.com'" <broonie@opensource.wolfsonmicro.com>, "'perex@perex.cz'" <perex@perex.cz>, "'tiwai@suse.de'" <tiwai@suse.de>, "'pablo@netfilter.org'" <pablo@netfilter.org>, "'kaber@trash.net'" <kaber@trash.net>, "'davem@davemloft.net'" <davem@davemloft.net>, "'rostedt@goodmis.org'" <rostedt@goodmis.org>, "'fweisbec@gmail.com'" <fweisbec@gmail.com>, "'mingo@redhat.com'" <mingo@redhat.com>, "'dmitry.torokhov@gmail.com'" <dmitry.torokhov@gmail.com>, 'rydber
List-Id: linux-input@vger.kernel.org

Hi 


I find there is some drivers use kmalloc to allocate large 
Memorys during module_init,  some can be changed to use vmalloc
To save some low mem, I add log in kernel to track ,
And list them here:

https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/tree/drivers/usb/gadget/f_mass_storage.c?h=master#n2724

https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/tree/sound/soc/soc-core.c?h=master#n3772

https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/tree/net/netfilter/nf_conntrack_ftp.c?h=master#n603
https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/tree/net/netfilter/nf_conntrack_h323_main.c?h=master#n1849
https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/tree/net/netfilter/nf_conntrack_irc.c?h=master#n247
https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/tree/net/netfilter/nf_conntrack_sane.c?h=master#n195

https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/tree/drivers/input/evdev.c?h=master#n403


they allocate large memory from 10k~64K , 
this will use lots of low mem, instead if we use 
vmalloc for these drivers , it will be good for some devices
like smart phone, we often encounter some errors like kmalloc failed 
because there is not enough low mem , especially when the device has physical 
memory less than 1GB .


could this module change the memory allocation into vmalloc ?

I was thinking that if we can introduce a helper function in kmalloc.h like this :

Kmalloc(size, flags)
{
	If (size > PAGE_SIZE && flags&CAN_USE_VMALLOC_FLAG)
		return vmalloc(size);
	Else
		return real_kmalloc(size);
}

Kfree(ptr)
{
	If (is_vmalloc_addr(ptr))
		Vfree(ptr);
	Else
		Kfree(ptr);
}


But we need add some flags to ensure always use kmalloc for
Some special use (dma etc..)

How do you think of it ?

Thanks
