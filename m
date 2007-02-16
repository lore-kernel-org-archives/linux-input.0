From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Add Cobalt button interface driver support
Date: Fri, 16 Feb 2007 10:15:11 -0500
Message-ID: <d120d5000702160715x6f64853y59abb8a22e7d164c@mail.gmail.com>
References: <20070216123608.733f04a3.yoichi_yuasa@tripeaks.co.jp>
	 <200702152309.44563.dtor@insightbb.com>
	 <200702160815.l1G8FEIr078415@mbox33.po.2iij.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200702160815.l1G8FEIr078415@mbox33.po.2iij.net>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 2/16/07, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> +
> +static int cobalt_buttons_open(struct inode *inode, struct file *file)
> +{
> +       buttons_timer.expires = jiffies + msecs_to_jiffies(BUTTONS_POLL_INTERVAL);
> +       add_timer(&buttons_timer);
> +
> +       return nonseekable_open(inode, file);
> +
> +}

Hi,

I am sorry, I was not clear enough - when I was talking about adding
cobalt_buttons_open/close I was not asking you to add a misc device to
the driver. I was talking about setting up open() and close() methods
in input_dev structure. These methods are called by input core when
first (or last) user opens or closes one of input interfaces, such as
/dev/input/eventX, /dev/input/jsX, etc and so it is naturally to
start/stop polling device from these functions.

Does this make sense?

-- 
Dmitry
