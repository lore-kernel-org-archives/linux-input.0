From: Nick Crews <ncrews@chromium.org>
Subject: Re: [PATCH v2] HID: intel-ish-hid: ISH firmware loader client driver
Date: Fri, 29 Mar 2019 16:26:50 -0700
Message-ID: <CAHX4x85ibvr2ua40X1T8gd-y54mahTj1H0MRZF7HPsPPECC=-Q@mail.gmail.com>
References: <1553804456-5329-1-git-send-email-rushikesh.s.kadam@intel.com>
 <CAHX4x876zC0BjQnAC0e3+b00QzfvSOgFnW-TfGLf6-u55q9Ftw@mail.gmail.com> <20190329195936.GA6971@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190329195936.GA6971@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rushikesh S Kadam <rushikesh.s.kadam@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, benjamin.tissoires@redhat.com, jikos@kernel.org, jettrink@chromium.org, Gwendal Grignou <gwendal@google.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Your reasonings sound good. One or two responses in line, otherwise
the version you just sent looks good.

On Fri, Mar 29, 2019 at 12:59 PM Rushikesh S Kadam
<rushikesh.s.kadam@intel.com> wrote:
>
> Hi Nick
> Please see my comments inline below,
>
> On Thu, Mar 28, 2019 at 11:02:52PM -0700, Nick Crews wrote:
> > This is so close! There are just one or two tiny things.
> >
> > On Thu, Mar 28, 2019 at 1:20 PM Rushikesh S Kadam
> > <rushikesh.s.kadam@intel.com> wrote:
>
> > > +/**
> > > + * loader_cl_send()    Send message from host to firmware
> > > + * @client_data:       Client data instance
> > > + * @out_msg            Message buffer to be sent to firmware
> > > + * @out_size           Size of out going message
> > > + * @in_msg             Message buffer where the incoming data copied.
> > > + *                     This buffer is allocated by calling
> > > + * @in_size            Max size of incoming message
> > > + *
> > > + * Return: Received buffer size on success, negative error code on failure.
> >
> > Number of bytes copied to in_msg? Maybe a bit different than number of
> > bytes received?
>
> Will change to say number of bytes copied.
>
> >
> > > + */
> > > +static int loader_cl_send(struct ishtp_cl_data *client_data,
> > > +                         u8 *out_msg, size_t out_size,
> > > +                         u8 *in_msg, size_t in_size)
> > > +{
> > > +       int rv;
> > > +       struct loader_msg_hdr *in_hdr;
> > > +       struct loader_msg_hdr *out_hdr = (struct loader_msg_hdr *)out_msg;
> > > +       struct ishtp_cl *loader_ishtp_cl = client_data->loader_ishtp_cl;
> > > +
> > > +       dev_dbg(cl_data_to_dev(client_data),
> > > +               "%s: command=%02lx is_response=%u status=%02x\n",
> > > +               __func__,
> > > +               out_hdr->command & CMD_MASK,
> > > +               out_hdr->command & IS_RESPONSE ? 1 : 0,
> > > +               out_hdr->status);
> > > +
> > > +       /* Setup in coming buffer & size */
> > > +       client_data->response.data = in_msg;
> > > +       client_data->response.max_size = in_size;
> > > +       client_data->response.error = 0;
> > > +       client_data->response.flag_response = false;
> >
> > nit:
> > Consider renaming to something a bit more descriptive
> > such as "response.received"?
> >
>
> Will do.
>
> > > +
> > > +       rv = ishtp_cl_send(loader_ishtp_cl, out_msg, out_size);
> > > +       if (rv < 0) {
> > > +               dev_err(cl_data_to_dev(client_data),
> > > +                       "ishtp_cl_send error %d\n", rv);
> > > +               return rv;
> > > +       }
> > > +
> > > +       wait_event_interruptible_timeout(client_data->response.wait_queue,
> > > +                                        client_data->response.flag_response,
> > > +                                        ISHTP_SEND_TIMEOUT);
> > > +       if (!client_data->response.flag_response) {
> > > +               dev_err(cl_data_to_dev(client_data),
> > > +                       "Timed out for response to command=%02lx",
> > > +                       out_hdr->command & CMD_MASK);
> > > +               return -ETIMEDOUT;
> > > +       }
> > > +
> > > +       if (client_data->response.error < 0)
> > > +               return client_data->response.error;
> > > +
> > > +       /* All response messages will contain a header */
> > > +       in_hdr = (struct loader_msg_hdr *)in_msg;
> > > +
> > > +       /* Sanity checks */
> > > +       if (!(in_hdr->command & IS_RESPONSE)) {
> > > +               dev_err(cl_data_to_dev(client_data),
> > > +                       "Invalid response to command\n");
> > > +               return -EIO;
> > > +       }
> > > +
> > > +       if (in_hdr->status) {
> > > +               dev_err(cl_data_to_dev(client_data),
> > > +                       "Loader returned status %d\n",
> > > +                       in_hdr->status);
> > > +               return -EIO;
> > > +       }
> >
> > There are two places these sanity checks happen: Here and in
> > process_recv(). I think they should all be in the same place. Before,
> > I said move them into here (since then we could return error codes),
> > but now that you added client_data->response.error, it seems
> > equivalent to move these down there. So I would put these two
> > checks down there, then you don't have to cast in_msg at all.
> > There is new context, but sorry to flip flop!
>
> No problem. Will move the check to process_recv().
>
> > > +       case LOADER_CMD_START:
> > > +               /* Sanity check */
> > > +               if (client_data->response.flag_response) {
> > > +                       dev_err(cl_data_to_dev(client_data),
> > > +                               "Previous firmware message not yet processed\n");
> > > +                       client_data->response.error = -EINVAL;
> > > +                       break;
> > > +               }

This check should probably happen first within process_recv(), otherwise in
earlier errors you are writing over someone else's client_data->response.error.
I would also move the following check on client_data->response.data upwards too.
That is effectively making the error checking for the arguments
happening first, before
the checking of the incoming message. The caller should deal with
invalid arguments
first before IO errors. And maybe change order of following checks
too, I think it
makes more sense to check for the message status before it's size, etc.

> > > +               if (!client_data->response.data) {
> > > +                       dev_err(cl_data_to_dev(client_data),
> > > +                               "Receiving buffer is null. Should be allocated by calling function\n");
> > > +                       client_data->response.error = -EINVAL;
> > > +                       break;
> > > +               }
> >
> > Here you are forcing the callers of loader_cl_send() to allocate some data,
> > but in multiple cases this isn't necessary. Maybe you considered this,
> > but perhaps
> > you could make it so if this is NULL then just don't copy any data,
> > but still succeed?
> > Then callers of loader_cl_send() can just use NULL as in_msg if they don't want
> > the returned data. Update docstring of loader_cl_send() if so.
>
> All loader firmware messages have a header, so a null is
> treated as an error case. Just a sanity check.
>
> >
> > > +
> > > +               if (data_len > client_data->response.max_size) {
> > > +                       dev_err(cl_data_to_dev(client_data),
> > > +                               "Received buffer size %zu is larger than allocated buffer %zu\n",
> > > +                               data_len, client_data->response.max_size);
> > > +                       client_data->response.error = -EMSGSIZE;
> > > +                       break;
> > > +               }
> >
> > Here you need to decide the meaning of the in_size arg for
> > loader_cl_send(): Does it mean
> > "The required size of incoming data" or "max size to copy to in_data"?
> > One is more strict, which
> > could be good for error checking, but the second is more in line to
> > the read() syscall and some
> > other read() functions. At the least fix the docstring of
> > loader_cl_send(). I think I'm fine with either,
> > maybe someone else has an opinion?
>
> >
> > This could be the alternative algorithm:
> >
> > bytes_to_copy = min(data_len, client_data->response.max_size);
> > client_data->response.size = bytes_to_copy;
> > if (bytes_to_copy && !client_data->response.data)
> >          error()
> > memcpy(client_data->response.data, b_in_proc->buffer.data, bytes_to_copy);
>
> I would say in_size is the "max size of incoming data".
>
> If the data exceeds the max size, I want to treat it as an
> error.
>
> The read() functions copy partial data, leaving remaining
> data behind, to be copied on next iteration. We don't expect
> or do that here, so should log an error.

Sounds good!

>
> >
> > > +
> > > +               /* Update the actual received buffer size */
> > > +               client_data->response.size = data_len;
> > > +
> > > +               /*
> > > +                * Copy the buffer received in firmware response for the
> > > +                * calling thread.
> > > +                */
> > > +               memcpy(client_data->response.data,
> > > +                      rb_in_proc->buffer.data, data_len);
> > > +
> > > +               /* Free the buffer */
> > > +               ishtp_cl_io_rb_recycle(rb_in_proc);
> > > +               rb_in_proc = NULL;
> > > +
> > > +               /* Wake the calling thread */
> > > +               client_data->response.flag_response = true;
> > > +               wake_up_interruptible(&client_data->response.wait_queue);
> > > +               break;

I think the caller should be woken in the error case too. Otherwise in
loader_cl_send()
we'll go through the timeout path, even though we didn't actually time out. That
makes the tail of this function simpler too!

> > > +
> > > +       default:
> > > +               dev_err(cl_data_to_dev(client_data),
> > > +                       "Invalid command=%02lx\n",
> > > +                       hdr->command & CMD_MASK);
> > > +               client_data->response.error = -EPROTO;
> > > +       }
> >
> > Instead of placing the "normal" code inside the successful cases of the switch
> > statement, move the "normal" code out here:
> > https://refactoring.com/catalog/replaceNestedConditionalWithGuardClauses.html
> >
> > Using these guard clauses has two benefits:
> > -reduces indenting and visual complexity
> > -separates main logic from error checking
>
> I think the switch-case isn't a good choice anymore. I do
> not do any case specific processing here. I'll drop the
> switch, instead add a "if" check at the start for valid
> commands. Ok?

Looks great!

>
> >
> > > +
> > > +end_error:
> > > +       /* Free the buffer if we did not do above */
> > > +       if (rb_in_proc)
> > > +               ishtp_cl_io_rb_recycle(rb_in_proc);
> > > +}
> > > +
> > > +/**
> > > + * loader_cl_event_cb() - bus driver callback for incoming message
> > > + * @device:            Pointer to the ishtp client device for which this
> > > + *                     message is targeted
> > > + *
> > > + * Remove the packet from the list and process the message by calling
> > > + * process_recv
> > > + */
> > > +static void loader_cl_event_cb(struct ishtp_cl_device *cl_device)
> > > +{
> > > +       struct ishtp_cl_rb *rb_in_proc;
> > > +       struct ishtp_cl_data *client_data;
> > > +       struct ishtp_cl *loader_ishtp_cl = ishtp_get_drvdata(cl_device);
> > > +
> > > +       client_data = ishtp_get_client_data(loader_ishtp_cl);
> >
> > You never use client_data, remove it?
>
> Will remove client_data.
>
> >
> > Or you could change process_recv() to use client_data as argument, since that is
> > sufficient for it.
> >
>
> > > +/**
> > > + * ish_fw_xfer_direct_dma() - Loads ISH firmware using direct dma
> > > + * @client_data:       Client data instance
> > > + * @fw:                        Poiner to firmware data struct in host memory
> >
> > add @fw_info. And there's still a typo above. and make fw_info const below?
>
> Will correct both.
>
> >
>
> > > +static int ish_fw_start(struct ishtp_cl_data *client_data)
> > > +{
> > > +       int rv;
> > > +       struct loader_start ldr_start;
> > > +       struct loader_msg_hdr ldr_start_ack;
> > > +
> > > +       memset(&ldr_start, 0, sizeof(ldr_start));
> > > +       ldr_start.hdr.command = LOADER_CMD_START;
> > > +       rv = loader_cl_send(client_data,
> > > +                           (u8 *)&ldr_start,
> > > +                           sizeof(ldr_start),
> > > +                           (u8 *)&ldr_start_ack,
> > > +                           sizeof(ldr_start_ack));
> > > +
> > > +       return rv;
> >
> > Remove rv and just return loader_cl_send()
>
> yes, will do.
>
> >
> > > +}
> > > +
> > > +/**
> > > + * load_fw_from_host() Loads ISH firmware from host
> > > + * @client_data:       Client data instance
> > > + *
> > > + * This function loads the ISH firmware to ISH SRAM and starts execution
> > > + *
> > > + * Return: 0 for success, negative error code for failure.
> > > + */
> > > +static int load_fw_from_host(struct ishtp_cl_data *client_data)
> > > +{
> > > +       int rv;
> > > +       u32 xfer_mode;
> > > +       char *filename;
> > > +       const struct firmware *fw;
> > > +       struct shim_fw_info fw_info;
> > > +       struct ishtp_cl *loader_ishtp_cl = client_data->loader_ishtp_cl;
> > > +
> > > +       client_data->flag_retry = false;
> > > +
> > > +       filename = kzalloc(FILENAME_SIZE, GFP_KERNEL);
> > > +       if (!filename) {
> > > +               rv = -ENOMEM;
> > > +               goto end_error;
> >
> > flag_retry is false here, so a re-attempt will not happen, is that OK?
>
> Should retry this case as well. Will add the flag.
>
> >
> > > +       }
> > > +
> > > +       /* Get filename of the ISH firmware to be loaded */
> > > +       rv = get_firmware_variant(client_data, filename);
> > > +       if (rv < 0)
> > > +               goto end_err_filename_buf_release;
> > > +
> > > +       rv = request_firmware(&fw, filename, cl_data_to_dev(client_data));
> > > +       if (rv < 0)
> > > +               goto end_err_filename_buf_release;
> > > +
> > > +       /* Step 1: Query Shim firmware loader properties */
> > > +
> > > +       rv = ish_query_loader_prop(client_data, fw, &fw_info);
> > > +       if (rv < 0)
> > > +               goto end_err_fw_release;
> > > +
> > > +       /* Step 2: Send the main firmware image to be loaded, to ISH SRAM */
> > > +
> > > +       xfer_mode = fw_info.ldr_capability.xfer_mode;
> > > +       if (xfer_mode & LOADER_XFER_MODE_DIRECT_DMA) {
> > > +               rv = ish_fw_xfer_direct_dma(client_data, fw, fw_info);
> > > +       } else if (xfer_mode & LOADER_XFER_MODE_ISHTP) {
> > > +               rv = ish_fw_xfer_ishtp(client_data, fw);
> > > +       } else {
> > > +               dev_err(cl_data_to_dev(client_data),
> > > +                       "No transfer mode selected in firmware\n");
> > > +               rv = -EINVAL;
> > > +       }
> > > +       if (rv < 0)
> > > +               goto end_err_fw_release;
> > > +
> > > +       /* Step 3: Start ISH main firmware exeuction */
> > > +
> > > +       rv = ish_fw_start(client_data);
> > > +       if (rv < 0)
> > > +               goto end_err_fw_release;
> > > +
> > > +       release_firmware(fw);
> > > +       kfree(filename);
> > > +       dev_info(cl_data_to_dev(client_data), "ISH firmware %s loaded\n",
> > > +                filename);
> > > +       return 0;
> > > +
> > > +end_err_fw_release:
> > > +       release_firmware(fw);
> > > +end_err_filename_buf_release:
> > > +       kfree(filename);
> > > +end_error:
> > > +       /* Keep a count of retries, and give up after 3 attempts */
> > > +       if (client_data->flag_retry && client_data->retry_count++ < 3) {
> >
> > #define MAX_LOAD_ATTEMPTS  at the top of the file?
> > Also consider explicitly initializing retry count to 0?
>
> Will do.
>
> >
> > > +               dev_warn(cl_data_to_dev(client_data),
> > > +                        "ISH host firmware load failed %d. Reset ISH & try again..\n",
> > > +                        rv);
> >
> > Maybe change Reset to Resetting? Reset sounds like it is requesting the
> > user to perform an action.
>
> Will change.
>
> >
> > > +               ish_hw_reset(ishtp_get_ishtp_device(loader_ishtp_cl));
> > > +       } else {
> > > +               dev_err(cl_data_to_dev(client_data),
> > > +                       "ISH host firmware load failed %d\n", rv);
> > > +       }
> > > +       return rv;
> > > +}
> > > +
> > > +static void load_fw_from_host_handler(struct work_struct *work)
> > > +{
> > > +       struct ishtp_cl_data *client_data;
> > > +
> > > +       client_data = container_of(work, struct ishtp_cl_data,
> > > +                                  work_fw_load);
> > > +       load_fw_from_host(client_data);
> >
> > If load_fw_from_host() fails then maybe just log the error code?
>
> We log the error code inside load_fw_from_host(). Are you
> suggesting to log again here?

I said this because there were a few cases where this could return
an error code but nothing was logged, such as when alloc() failed.
It's either log everything in the sub-functions and nothing here,
or log nothing in sub functions and everything here. You already
have the first, which I think is better since it has better specificity.
So what you have here is good.
That means that you should make sure EVERY error is logged though,
so track down those few cases. I think it's everywhere you return -ENOMEM.
I replied inline in your v3 patch below.

>
> >
> > > +
> > > +late_initcall(ish_loader_init);
> > > +module_exit(ish_loader_exit);
> > > +
> > > +module_param(dma_buf_size_limit, int, 0644);
> > > +MODULE_PARM_DESC(dma_buf_size_limit, "Limit the DMA buf size to this value in bytes");
> > > +
> > > +MODULE_DESCRIPTION("ISH ISH-TP Host firmware Loader Client Driver");
> > > +MODULE_AUTHOR("Rushikesh S Kadam <rushikesh.s.kadam@intel.com>");
> > > +
> > > +MODULE_LICENSE("GPL v2");
> > > +MODULE_ALIAS("ishtp:*");
> > > --
> > > 1.9.1
> > >
> >
> > After those final tweaks, then oh my goodness,
> > Acked-by: Nick Crews <ncrews@chromium.org>
>
> Thanks
> Rushikesh
>
> --
