From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] Input: uinput - fix Spectre v1 vulnerability
Date: Tue, 16 Oct 2018 19:52:58 +0200
Message-ID: <ead3e95a-1acb-362a-0ee2-d02dbc4f378c@embeddedor.com>
References: <20181016111313.GA28307@embeddedor.com>
 <20181016172107.GA230131@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181016172107.GA230131@dtor-ws>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

On 10/16/18 7:21 PM, Dmitry Torokhov wrote:
> Hi Gustavo,
> 
> On Tue, Oct 16, 2018 at 01:13:13PM +0200, Gustavo A. R. Silva wrote:
>> setup.code can be indirectly controlled by user-space, hence leading to
>> a potential exploitation of the Spectre variant 1 vulnerability.
>>
>> This issue was detected with the help of Smatch:
>>
>> drivers/input/misc/uinput.c:512 uinput_abs_setup() warn: potential
>> spectre issue 'dev->absinfo' [w] (local cap)
>>
>> Fix this by sanitizing setup.code before using it to index dev->absinfo.
> 
> So we are saying that attacker, by repeatedly calling ioctl(...,
> UI_ABS_SETUP, ...) will be able to poison branch predictor and discover
> another program or kernel secrets? But uinput is a privileged interface
> open to root only, as it allows injecting arbitrary keystrokes into the
> kernel. And since only root can use uinput, meh?
> 

Oh I see... in that case this is a false positive.

Although, I wonder if all these operations are only accessible to root:

static const struct file_operations uinput_fops = {
        .owner          = THIS_MODULE,
        .open           = uinput_open,
        .release        = uinput_release,
        .read           = uinput_read,
        .write          = uinput_write,
        .poll           = uinput_poll,
        .unlocked_ioctl = uinput_ioctl,
#ifdef CONFIG_COMPAT
        .compat_ioctl   = uinput_compat_ioctl,
#endif
        .llseek         = no_llseek,
};

Thanks for the feedback.
--
Gustavo
