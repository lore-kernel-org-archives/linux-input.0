From: Amit Virdi <amit.virdi@st.com>
Subject: Re: sleeping function called from invalid context
Date: Wed, 11 May 2011 14:13:21 +0530
Message-ID: <4DCA4C29.20403@st.com>
References: <4DC8CF50.4040003@st.com>
	<20110510103256.58d61861@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110510103256.58d61861@bob.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alan Cox <alan@linux.intel.com>
Cc: "samuel@sortiz.org" <samuel@sortiz.org>, Armando VISCONTI <armando.visconti@st.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shiraz HASHIM <shiraz.hashim@st.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-input@vger.kernel.org

Hey Alan,

On 5/10/2011 3:02 PM, Alan Cox wrote:
>> On analysis, I found that this is due to the change introduced in
>> tty_ioctl.c where the termios mutex is taken to protect against
>> parallel throttle/unthrottle. Probably IrCOMM stack code wasn't
>> tested before merging this patch.
>>
>> Please suggest what should be done with the IrCOMM protocol stack
>> code to resolve this problem?
>
> It looks like the comments are wrong
>
>          /*
>           * Just give it over to the line discipline. There is no need to
>           * involve the flip buffers, since we are not running in an
>          interrupt
>           * handler
>           */
>
>
> appears to be completely untrue
>
> I suspect it just needs to use the tty_flip_buffer functions properly
> instead of trying to do clever shortcuts
>
>
> 	tty_insert_flip_string(self->tty, skb->data, skb->len);
> 	tty_flip_buffer_push(self->tty);
>
> .
>

I incorporated the change suggested by you and tested the stack again. 
It is working perfectly fine - no stack trace is printed now. I'll be 
sending the patch soon.

Thanks n Regards
Amit Virdi
