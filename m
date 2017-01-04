From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 7/7] misc: intel-ish-client: add intel ishtp clients
 driver
Date: Wed, 4 Jan 2017 14:13:35 +0100
Message-ID: <20170104131335.GB8832@kroah.com>
References: <1482456149-4841-1-git-send-email-even.xu@intel.com>
 <1482456149-4841-7-git-send-email-even.xu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1482456149-4841-7-git-send-email-even.xu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Even Xu <even.xu@intel.com>
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com, srinivas.pandruvada@linux.intel.com, arnd@arndb.de, andriy.shevchenko@intel.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Dec 23, 2016 at 09:22:29AM +0800, Even Xu wrote:
> +static int ishtp_cl_open(struct inode *inode, struct file *file)
> +{
> +	struct miscdevice *misc = file->private_data;
> +	struct ishtp_cl *cl;
> +	struct ishtp_device *dev;
> +	struct ishtp_cl_miscdev *ishtp_cl_misc;
> +	int ret;
> +
> +	/* Non-blocking semantics are not supported */
> +	if (file->f_flags & O_NONBLOCK)
> +		return -EINVAL;
> +
> +	ishtp_cl_misc = container_of(misc,
> +				struct ishtp_cl_miscdev, cl_miscdev);
> +	if (!ishtp_cl_misc || !ishtp_cl_misc->cl_device)
> +		return -ENODEV;

How can ishtp_cl_misc ever be NULL?  Are you sure you know what
container_of() really does here?  :)

> +	dev = ishtp_cl_misc->cl_device->ishtp_dev;
> +	if (!dev)
> +		return -ENODEV;

How can dev be NULL?

> +
> +	mutex_lock(&ishtp_cl_misc->cl_mutex);
> +
> +	/*
> +	 * Every client only supports one opened instance
> +	 * at the sametime.
> +	 */
> +	if (ishtp_cl_misc->cl) {
> +		ret = -EBUSY;
> +		goto out_unlock;
> +	}
> +
> +	cl = ishtp_cl_allocate(dev);
> +	if (!cl) {
> +		ret = -ENOMEM;
> +		goto out_free;
> +	}
> +
> +	if (dev->dev_state != ISHTP_DEV_ENABLED) {
> +		ret = -ENODEV;
> +		goto out_free;
> +	}
> +
> +	ret = ishtp_cl_link(cl, ISHTP_HOST_CLIENT_ID_ANY);
> +	if (ret)
> +		goto out_free;
> +
> +	ishtp_cl_misc->cl = cl;
> +
> +	file->private_data = ishtp_cl_misc;
> +
> +	mutex_unlock(&ishtp_cl_misc->cl_mutex);
> +
> +	return nonseekable_open(inode, file);
> +
> +out_free:
> +	kfree(cl);
> +out_unlock:
> +	mutex_unlock(&ishtp_cl_misc->cl_mutex);
> +	return ret;
> +}
> +
> +#define WAIT_FOR_SEND_SLICE_MS		100
> +#define WAIT_FOR_SEND_COUNT		10
> +
> +static int ishtp_cl_release(struct inode *inode, struct file *file)
> +{
> +	struct ishtp_cl_miscdev *ishtp_cl_misc = file->private_data;
> +	struct ishtp_cl *cl;
> +	struct ishtp_cl_rb *rb;
> +	struct ishtp_device *dev;
> +	int try = WAIT_FOR_SEND_COUNT;
> +	int ret;
> +
> +	mutex_lock(&ishtp_cl_misc->cl_mutex);
> +
> +	/* Wake up from waiting if anyone wait on it */
> +	wake_up_interruptible(&ishtp_cl_misc->read_wait);
> +
> +	cl = ishtp_cl_misc->cl;
> +	dev = cl->dev;
> +
> +	/*
> +	 * May happen if device sent FW reset or was intentionally
> +	 * halted by host SW. The client is then invalid.
> +	 */
> +	if ((dev->dev_state == ISHTP_DEV_ENABLED) &&
> +			(cl->state == ISHTP_CL_CONNECTED)) {
> +		/*
> +		 * Check and wait 1s for message in tx_list to be sent.
> +		 */
> +		do {
> +			if (!ishtp_cl_tx_empty(cl))
> +				msleep_interruptible(WAIT_FOR_SEND_SLICE_MS);
> +			else
> +				break;
> +		} while (--try);

So just try it a bunch and hope it all works out?  No error message if
something went wrong?  Why not try forever?  Why that specific number of
trys?  This feels hacky.


> +
> +		cl->state = ISHTP_CL_DISCONNECTING;
> +		ret = ishtp_cl_disconnect(cl);
> +	}
> +
> +	ishtp_cl_unlink(cl);
> +	ishtp_cl_flush_queues(cl);
> +	/* Disband and free all Tx and Rx client-level rings */
> +	ishtp_cl_free(cl);
> +
> +	ishtp_cl_misc->cl = NULL;
> +
> +	rb = ishtp_cl_misc->read_rb;
> +	if (rb) {
> +		ishtp_cl_io_rb_recycle(rb);
> +		ishtp_cl_misc->read_rb = NULL;
> +	}
> +
> +	file->private_data = NULL;
> +
> +	mutex_unlock(&ishtp_cl_misc->cl_mutex);
> +
> +	return ret;
> +}
> +
> +static ssize_t ishtp_cl_read(struct file *file, char __user *ubuf,
> +			size_t length, loff_t *offset)
> +{
> +	struct ishtp_cl_miscdev *ishtp_cl_misc = file->private_data;
> +	struct ishtp_cl *cl;
> +	struct ishtp_cl_rb *rb;
> +	struct ishtp_device *dev;
> +	int ret = 0;
> +
> +	/* Non-blocking semantics are not supported */
> +	if (file->f_flags & O_NONBLOCK)
> +		return -EINVAL;
> +
> +	mutex_lock(&ishtp_cl_misc->cl_mutex);
> +
> +	cl = ishtp_cl_misc->cl;
> +
> +	/*
> +	 * ISHFW reset will cause cl be freed and re-allocated.
> +	 * So must make sure cl is re-allocated successfully.
> +	 */
> +	if (!cl || !cl->dev) {
> +		ret = -ENODEV;
> +		goto out_unlock;
> +	}

How can these ever be true?

> +
> +	dev = cl->dev;
> +	if (dev->dev_state != ISHTP_DEV_ENABLED) {
> +		ret = -ENODEV;
> +		goto out_unlock;
> +	}
> +
> +	if (ishtp_cl_misc->read_rb)
> +		goto get_rb;
> +
> +	rb = ishtp_cl_rx_get_rb(cl);
> +	if (rb)
> +		goto copy_buffer;
> +
> +	/*
> +	 * Release mutex for other operation can be processed parallelly
> +	 * during waiting.
> +	 */
> +	mutex_unlock(&ishtp_cl_misc->cl_mutex);
> +
> +	if (wait_event_interruptible(ishtp_cl_misc->read_wait,
> +			ishtp_cl_misc->read_rb != NULL)) {
> +		dev_err(&ishtp_cl_misc->cl_device->dev,
> +			"Wake up not successful;"
> +			"signal pending = %d signal = %08lX\n",
> +			signal_pending(current),
> +			current->pending.signal.sig[0]);

Why spam the error log for this?

> +		return -ERESTARTSYS;
> +	}
> +
> +	mutex_lock(&ishtp_cl_misc->cl_mutex);
> +
> +	/*
> +	 * waitqueue can be woken up in many cases, so must check
> +	 * if dev and cl is still available.
> +	 */
> +	if (dev->dev_state != ISHTP_DEV_ENABLED) {
> +		ret = -ENODEV;
> +		goto out_unlock;
> +	}
> +
> +	cl = ishtp_cl_misc->cl;
> +	if (!cl) {
> +		ret = -ENODEV;
> +		goto out_unlock;
> +	}
> +
> +	if (cl->state == ISHTP_CL_INITIALIZING ||
> +		cl->state == ISHTP_CL_DISCONNECTED ||
> +		cl->state == ISHTP_CL_DISCONNECTING) {
> +		ret = -EBUSY;
> +		goto out_unlock;
> +	}
> +
> +get_rb:
> +	rb = ishtp_cl_misc->read_rb;
> +	if (!rb) {
> +		ret = -ENODEV;
> +		goto out_unlock;
> +	}
> +
> +copy_buffer:
> +	/* Now copy the data to user space */
> +	if (!length || !ubuf || *offset > rb->buf_idx) {
> +		ret = -EMSGSIZE;
> +		goto out_unlock;
> +	}
> +
> +	/*
> +	 * length is being truncated, however buf_idx may
> +	 * point beyond that.
> +	 */
> +	length = min_t(size_t, length, rb->buf_idx - *offset);
> +
> +	if (copy_to_user(ubuf, rb->buffer.data + *offset, length)) {
> +		ret = -EFAULT;
> +		goto out_unlock;
> +	}
> +
> +	*offset += length;
> +	if ((unsigned long)*offset < rb->buf_idx)
> +		goto out_unlock;
> +
> +	ishtp_cl_io_rb_recycle(rb);
> +	ishtp_cl_misc->read_rb = NULL;
> +	*offset = 0;
> +
> +out_unlock:
> +	mutex_unlock(&ishtp_cl_misc->cl_mutex);
> +	return ret < 0 ? ret : length;
> +}

I still don't understand what is being read/written through this
character device node.  What is it used for?

thanks,

greg k-h
