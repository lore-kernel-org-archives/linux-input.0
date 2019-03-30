From: Rushikesh S Kadam <rushikesh.s.kadam@intel.com>
Subject: Re: [PATCH v3] HID: intel-ish-hid: ISH firmware loader client driver
Date: Sat, 30 Mar 2019 15:52:30 +0530
Message-ID: <20190330102230.GB19202@intel.com>
References: <1553889813-17677-1-git-send-email-rushikesh.s.kadam@intel.com>
 <CAHX4x85jFVYhOpRCKfvhYEqhXFwpKaK3_5gEit1EMaXY3L4Z4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHX4x85jFVYhOpRCKfvhYEqhXFwpKaK3_5gEit1EMaXY3L4Z4g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Crews <ncrews@chromium.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, benjamin.tissoires@redhat.com, jikos@kernel.org, jettrink@chromium.org, Gwendal Grignou <gwendal@google.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Nick
I've few comments below about your suggestions,

On Fri, Mar 29, 2019 at 04:30:18PM -0700, Nick Crews wrote:
> On Fri, Mar 29, 2019 at 1:03 PM Rushikesh S Kadam
> <rushikesh.s.kadam@intel.com> wrote:
> >
> > +/**
> > + * ish_fw_xfer_ishtp() Loads ISH firmware using ishtp interface
> > + * @client_data:       Client data instance
> > + * @fw:                        Pointer to firmware data struct in host memory
> > + *
> > + * This function uses ISH-TP to transfer ISH firmware from host to
> > + * ISH SRAM. Lower layers may use IPC or DMA depending on firmware
> > + * support.
> > + *
> > + * Return: 0 for success, negative error code for failure.
> > + */
> > +static int ish_fw_xfer_ishtp(struct ishtp_cl_data *client_data,
> > +                            const struct firmware *fw)
> > +{
> > +       int rv;
> > +       u32 fragment_offset, fragment_size, payload_max_size;
> > +       struct loader_xfer_ipc_fragment *ldr_xfer_ipc_frag;
> > +       struct loader_msg_hdr ldr_xfer_ipc_ack;
> > +
> > +       payload_max_size =
> > +               LOADER_SHIM_IPC_BUF_SIZE - IPC_FRAGMENT_DATA_PREAMBLE;
> > +
> > +       ldr_xfer_ipc_frag = kzalloc(LOADER_SHIM_IPC_BUF_SIZE, GFP_KERNEL);
> > +       if (!ldr_xfer_ipc_frag) {
> 
> Log error here.
> 

The error code is logged in calling function
load_fw_from_host(). Is that good enough?

I believe the checkpatch script too, would
recommend against adding debug print for ENOMEM
error.

> > +       /*
> > +        * payload_max_size should be set to minimum of
> > +        *  (1) Size of firmware to be loaded,
> > +        *  (2) Max DMA buffer size supported by Shim firmware,
> > +        *  (3) DMA buffer size limit set by boot_param dma_buf_size_limit.
> > +        */
> > +       payload_max_size = min3(fw->size,
> > +                               (size_t)shim_fw_buf_size,
> > +                               (size_t)dma_buf_size_limit);
> > +
> > +       /*
> > +        * Buffer size should be multiple of cacheline size
> > +        * if it's not, select the previous cacheline boundary.
> > +        */
> > +       payload_max_size &= ~(L1_CACHE_BYTES - 1);
> > +
> > +       dma_buf = kmalloc(payload_max_size, GFP_KERNEL | GFP_DMA32);
> > +       if (!dma_buf) {
> 
> Log error here.
 
Same comment as above.

> > +static int load_fw_from_host(struct ishtp_cl_data *client_data)
> > +{
> > +       int rv;
> > +       u32 xfer_mode;
> > +       char *filename;
> > +       const struct firmware *fw;
> > +       struct shim_fw_info fw_info;
> > +       struct ishtp_cl *loader_ishtp_cl = client_data->loader_ishtp_cl;
> > +
> > +       client_data->flag_retry = false;
> > +
> > +       filename = kzalloc(FILENAME_SIZE, GFP_KERNEL);
> > +       if (!filename) {
> > +               client_data->flag_retry = true;
> > +               rv = -ENOMEM;
> 
> log error here
> 

We log the error code below.

> > +/**
> > + * loader_ishtp_cl_probe() - ISH-TP client driver probe
> > + * @cl_device:         ISH-TP client device instance
> > + *
> > + * This function gets called on device create on ISH-TP bus
> > + *
> > + * Return: 0 for success, negative error code for failure
> > + */
> > +static int loader_ishtp_cl_probe(struct ishtp_cl_device *cl_device)
> > +{
> > +       struct ishtp_cl *loader_ishtp_cl;
> > +       struct ishtp_cl_data *client_data;
> > +       int rv;
> > +
> > +       client_data = devm_kzalloc(ishtp_device(cl_device),
> > +                                  sizeof(*client_data),
> > +                                  GFP_KERNEL);
> > +       if (!client_data)
> 
> log error here

Again, I thought it was against practise to log
"out of memory" debug prints in probe()

But will add if you tell me this is the right way.

> 
> > +               return -ENOMEM;
> > +
> > +       loader_ishtp_cl = ishtp_cl_allocate(cl_device);
> > +       if (!loader_ishtp_cl)
> 
> log error here

Same comment.

Thanks
Rushikesh

> 
> > +               return -ENOMEM;
> > +
> > +       ishtp_set_drvdata(cl_device, loader_ishtp_cl);
> > +       ishtp_set_client_data(loader_ishtp_cl, client_data);
> > +       client_data->loader_ishtp_cl = loader_ishtp_cl;
> > +       client_data->cl_device = cl_device;
> > +
> > +       init_waitqueue_head(&client_data->response.wait_queue);
> > +
> > +       INIT_WORK(&client_data->work_ishtp_reset,
> > +                 reset_handler);
> > +       INIT_WORK(&client_data->work_fw_load,
> > +                 load_fw_from_host_handler);
> > +
> > +       rv = loader_init(loader_ishtp_cl, 0);
> > +       if (rv < 0) {
> > +               ishtp_cl_free(loader_ishtp_cl);
> > +               return rv;
> > +       }
> > +       ishtp_get_device(cl_device);
> > +
> > +       client_data->retry_count = 0;
> > +
> > +       /* ISH firmware loading from host */
> > +       schedule_work(&client_data->work_fw_load);
> > +
> > +       return 0;
> > +}
> > +
> > +/**
> > + * loader_ishtp_cl_remove() - ISH-TP client driver remove
> > + * @cl_device:         ISH-TP client device instance
> > + *
> > + * This function gets called on device remove on ISH-TP bus
> > + *
> > + * Return: 0
> > + */
> > +static int loader_ishtp_cl_remove(struct ishtp_cl_device *cl_device)
> > +{
> > +       struct ishtp_cl_data *client_data;
> > +       struct ishtp_cl *loader_ishtp_cl = ishtp_get_drvdata(cl_device);
> > +
> > +       client_data = ishtp_get_client_data(loader_ishtp_cl);
> > +
> > +       /*
> > +        * The sequence of the following two cancel_work_sync() is
> > +        * important. The work_fw_load can in turn schedue
> > +        * work_ishtp_reset, so first cancel work_fw_load then
> > +        * cancel work_ishtp_reset.
> > +        */
> > +       cancel_work_sync(&client_data->work_fw_load);
> > +       cancel_work_sync(&client_data->work_ishtp_reset);
> > +       loader_deinit(loader_ishtp_cl);
> > +       ishtp_put_device(cl_device);
> > +
> > +       return 0;
> > +}
> > +
> > +/**
> > + * loader_ishtp_cl_reset() - ISH-TP client driver reset
> > + * @cl_device:         ISH-TP client device instance
> > + *
> > + * This function gets called on device reset on ISH-TP bus
> > + *
> > + * Return: 0
> > + */
> > +static int loader_ishtp_cl_reset(struct ishtp_cl_device *cl_device)
> > +{
> > +       struct ishtp_cl_data *client_data;
> > +       struct ishtp_cl *loader_ishtp_cl = ishtp_get_drvdata(cl_device);
> > +
> > +       client_data = ishtp_get_client_data(loader_ishtp_cl);
> > +
> > +       schedule_work(&client_data->work_ishtp_reset);
> > +
> > +       return 0;
> > +}
> > +
> > +static struct ishtp_cl_driver  loader_ishtp_cl_driver = {
> > +       .name = "ish-loader",
> > +       .guid = &loader_ishtp_guid,
> > +       .probe = loader_ishtp_cl_probe,
> > +       .remove = loader_ishtp_cl_remove,
> > +       .reset = loader_ishtp_cl_reset,
> > +};
> > +
> > +static int __init ish_loader_init(void)
> > +{
> > +       return ishtp_cl_driver_register(&loader_ishtp_cl_driver, THIS_MODULE);
> > +}
> > +
> > +static void __exit ish_loader_exit(void)
> > +{
> > +       ishtp_cl_driver_unregister(&loader_ishtp_cl_driver);
> > +}
> > +
> > +late_initcall(ish_loader_init);
> > +module_exit(ish_loader_exit);
> > +
> > +module_param(dma_buf_size_limit, int, 0644);
> > +MODULE_PARM_DESC(dma_buf_size_limit, "Limit the DMA buf size to this value in bytes");
> > +
> > +MODULE_DESCRIPTION("ISH ISH-TP Host firmware Loader Client Driver");
> > +MODULE_AUTHOR("Rushikesh S Kadam <rushikesh.s.kadam@intel.com>");
> > +
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_ALIAS("ishtp:*");
> > --
> > 1.9.1
> >

-- 
